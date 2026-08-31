import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform, debugPrint;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

/// Single API boundary for the Flutter app.
///
/// Physical Android device over USB (recommended for development):
///   1. Start Laravel:  php artisan serve --host=0.0.0.0 --port=8000
///   2. Forward the port over the cable:  adb reverse tcp:8000 tcp:8000
///   Then the phone reaches the backend at http://127.0.0.1:8000 — no Wi-Fi,
///   no firewall, no IP address to keep in sync. Re-run `adb reverse` after
///   unplugging the phone or restarting adb.
///
/// Physical Android device over Wi-Fi (phone + PC on the SAME network):
///   Override the URL with your PC's LAN IP, e.g.
///   flutter run --dart-define=API_BASE_URL=http://192.168.88.179:8000/api
class ApiService {
  ApiService._();

  static final ApiService instance = ApiService._();

  /// Allows the API URL to be overridden without changing the code.
  ///
  /// Example (Wi-Fi, using the PC's LAN IP):
  /// flutter run --dart-define=API_BASE_URL=http://192.168.88.179:8000/api
  static const String _configuredUrl = String.fromEnvironment('API_BASE_URL');

  /// API base URL.
  static String get baseUrl {
    // If API_BASE_URL was supplied using --dart-define, always use that value.
    if (_configuredUrl.isNotEmpty) {
      return _configuredUrl;
    }
    //Every time you reconnect the phone or restart adb
    //Re-run:
    //adb reverse tcp:8000 tcp:8000

    // Android emulator reaches the host machine through the 10.0.2.2 alias.
    // A physical device over USB reaches it through 127.0.0.1 once
    // `adb reverse tcp:8000 tcp:8000` is running (see the class doc above).
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      const usbDebugging = bool.fromEnvironment(
        'ANDROID_USB',
        defaultValue: true,
      );
      return usbDebugging
          ? 'http://127.0.0.1:8000/api'
          : 'http://10.0.2.2:8000/api';
    }

    // Flutter Web / desktop / iOS simulator can access the backend via localhost.
    return 'http://127.0.0.1:8000/api';
  }

  String? _token;

  /// Restores a previously saved login token from disk. Call once on app
  /// startup (see main.dart) so a logged-in user stays signed in after the
  /// app is closed and reopened.
  Future<void> loadSession() async {
    try {
      final file = await _sessionFile();
      if (await file.exists()) {
        final saved = (await file.readAsString()).trim();
        if (saved.isNotEmpty) {
          _token = saved;
          debugPrint('SESSION: restored saved login.');
        }
      }
    } catch (e) {
      debugPrint('SESSION: could not load ($e)');
    }
  }

  Future<File> _sessionFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/uda_session.txt');
  }

  Future<void> _persistToken(String? token) async {
    try {
      final file = await _sessionFile();
      if (token == null || token.isEmpty) {
        if (await file.exists()) await file.delete();
      } else {
        await file.writeAsString(token);
      }
    } catch (e) {
      debugPrint('SESSION: could not persist ($e)');
    }
  }

  /// Common HTTP headers.
  Map<String, String> get _headers {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',

      // Add authentication token when available.
      if (_token != null && _token!.isNotEmpty)
        'Authorization': 'Bearer $_token',
    };
  }

  /// Sends an HTTP request to the Laravel API.
  Future<dynamic> _request(
    String method,
    String path, [
    Map<String, dynamic>? body,
  ]) async {
    // Remove accidental leading/trailing slashes so that
    // we don't create URLs such as /api//login.
    final cleanPath = path.replaceFirst(RegExp(r'^/+'), '');

    final uri = Uri.parse('$baseUrl/$cleanPath');

    debugPrint('');
    debugPrint('========================================');
    debugPrint('API REQUEST');
    debugPrint('========================================');
    debugPrint('Method: $method');
    debugPrint('URL: $uri');

    if (body != null) {
      debugPrint('Body: ${jsonEncode(body)}');
    }

    final request = http.Request(method, uri);

    request.headers.addAll(_headers);

    if (body != null) {
      request.body = jsonEncode(body);
    }

    http.StreamedResponse response;

    try {
      response = await request.send().timeout(const Duration(seconds: 20));
    } on TimeoutException {
      debugPrint('API ERROR: Request timed out');

      throw const ApiException(
        'Could not reach the UDA server. '
        'Please check that your phone and computer are connected '
        'to the same network and that the backend is running.',
      );
    } on http.ClientException catch (e) {
      debugPrint('API CLIENT ERROR: $e');

      throw ApiException(
        'Could not connect to the UDA server at $baseUrl. '
        'Make sure the backend is running and reachable from your phone.',
      );
    } catch (e) {
      debugPrint('API CONNECTION ERROR: $e');

      throw ApiException(
        'Could not connect to the UDA server at $baseUrl. '
        'Make sure the backend is running and reachable from your phone.',
      );
    }

    final text = await response.stream.bytesToString();

    debugPrint('Status Code: ${response.statusCode}');
    debugPrint('Response: $text');
    debugPrint('========================================');

    dynamic data;

    try {
      data = text.isEmpty ? null : jsonDecode(text);
    } catch (_) {
      // Backend did not return JSON.
      data = text;
    }

    // Handle HTTP errors.
    if (response.statusCode < 200 || response.statusCode >= 300) {
      String message = 'Request failed (${response.statusCode})';

      if (data is Map<String, dynamic>) {
        // Laravel commonly returns:
        // { "message": "Something went wrong" }
        if (data['message'] != null) {
          message = data['message'].toString();
        }

        // Laravel validation errors commonly look like:
        // {
        //   "message": "...",
        //   "errors": {
        //      "email": ["The email has already been taken."]
        //   }
        // }
        if (data['errors'] is Map) {
          final errors = data['errors'] as Map;

          final errorMessages = <String>[];

          for (final entry in errors.entries) {
            final value = entry.value;

            if (value is List) {
              for (final error in value) {
                errorMessages.add(error.toString());
              }
            } else {
              errorMessages.add(value.toString());
            }
          }

          if (errorMessages.isNotEmpty) {
            message = errorMessages.join('\n');
          }
        }
      } else if (data is String && data.isNotEmpty) {
        message = data;
      }

      throw ApiException(message);
    }

    return data;
  }

  /// GET request for resources that return a list.
  Future<List<Map<String, dynamic>>> getList(String resource) async {
    final data = await _request('GET', resource);

    dynamic values;

    if (data is Map && data['data'] is List) {
      values = data['data'];
    } else {
      values = data;
    }

    if (values is! List) {
      throw const ApiException('The server returned an unexpected response.');
    }

    return values
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  /// Login user.
  Future<Map<String, dynamic>> login(String email, String password) async {
    final data = await _request('POST', 'login', {
      'email': email.trim(),
      'password': password,
    });

    if (data is! Map) {
      throw const ApiException(
        'The server returned an invalid login response.',
      );
    }

    final result = Map<String, dynamic>.from(data);

    // Store authentication token.
    final token = result['token'];

    if (token != null) {
      _token = token.toString();
      await _persistToken(_token);

      debugPrint('LOGIN: Authentication token received.');
    } else {
      debugPrint('LOGIN: No authentication token returned.');
    }

    return result;
  }

  /// Register a new user.
  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    final data = await _request('POST', 'register', {
      'name': name.trim(),
      'email': email.trim(),
      'password': password,
    });

    if (data is! Map) {
      throw const ApiException(
        'The server returned an invalid registration response.',
      );
    }

    final result = Map<String, dynamic>.from(data);

    // Store authentication token if registration
    // automatically logs the user in.
    final token = result['token'];

    if (token != null) {
      _token = token.toString();
      await _persistToken(_token);

      debugPrint('REGISTER: Authentication token received.');
    } else {
      debugPrint('REGISTER: No authentication token returned.');
    }

    return result;
  }

  /// Log the current user out locally: clears the token from memory and disk.
  Future<void> logout() async {
    _token = null;
    await _persistToken(null);

    debugPrint('LOGOUT: Authentication token removed.');
  }

  /// Returns whether the app currently has an authentication token.
  bool get isLoggedIn {
    return _token != null && _token!.isNotEmpty;
  }

  /// Send a contact message.
  Future<void> sendContact({
    required String name,
    required String email,
    String? subject,
    required String message,
  }) async {
    await _request('POST', 'contacts', {
      'name': name.trim(),
      'email': email.trim(),
      if (subject != null && subject.trim().isNotEmpty)
        'subject': subject.trim(),
      'message': message.trim(),
    });
  }

  /// Ask a question.
  Future<void> askQuestion({int? userId, required String question}) async {
    await _request('POST', 'questions', {
      if (userId != null) 'user_id': userId,
      'question_text': question.trim(),
    });
  }

  // ---------------------------------------------------------------------------
  // Community feed
  // ---------------------------------------------------------------------------

  Future<List<Map<String, dynamic>>> getPosts() async {
    final data = await _request('GET', 'posts');
    final list = data is Map && data['data'] is List ? data['data'] : data;
    if (list is! List) return const [];
    return list
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  Future<Map<String, dynamic>> createPost({
    String content = '',
    String? mediaPath,
  }) async {
    final uri = Uri.parse('$baseUrl/posts');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Accept'] = 'application/json'
      ..fields['content'] = content;
    if (_token != null && _token!.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $_token';
    }
    if (mediaPath != null && mediaPath.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('media', mediaPath));
    }

    http.StreamedResponse response;
    try {
      response = await request.send().timeout(const Duration(seconds: 30));
    } on TimeoutException {
      throw const ApiException('Could not reach the UDA server.');
    } catch (_) {
      throw ApiException('Could not connect to the UDA server at $baseUrl.');
    }

    final text = await response.stream.bytesToString();
    final decoded = text.isEmpty ? null : jsonDecode(text);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final msg = decoded is Map
          ? (decoded['errors'] is Map
                ? (decoded['errors'] as Map).values
                      .expand((v) => v is List ? v : [v])
                      .join('\n')
                : (decoded['message']?.toString() ?? 'Post failed'))
          : 'Post failed (${response.statusCode})';
      throw ApiException(msg);
    }
    return Map<String, dynamic>.from(decoded as Map);
  }

  Future<Map<String, dynamic>> togglePostLike(int postId) async {
    final data = await _request('POST', 'posts/$postId/like');
    return Map<String, dynamic>.from(data as Map);
  }

  Future<void> sharePost(int postId) async {
    await _request('POST', 'posts/$postId/share');
  }

  Future<List<Map<String, dynamic>>> getPostComments(int postId) async {
    final data = await _request('GET', 'posts/$postId/comments');
    if (data is! List) return const [];
    return data
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  Future<Map<String, dynamic>> addPostComment(int postId, String body) async {
    final data = await _request('POST', 'posts/$postId/comments', {
      'body': body.trim(),
    });
    return Map<String, dynamic>.from(data as Map);
  }

  Future<void> deletePost(int postId) async {
    await _request('DELETE', 'posts/$postId');
  }

  /// Submit a donation from the "Fundraise" form.
  Future<void> submitDonation({
    required String name,
    required String email,
    required double amount,
    String? category,
    String currency = 'USD',
    String? location,
    String? comment,
  }) async {
    await _request('POST', 'donations', {
      'name': name.trim(),
      'email': email.trim(),
      'amount': amount,
      'currency': currency,
      if (category != null && category.isNotEmpty) 'category': category,
      if (location != null && location.isNotEmpty) 'location': location,
      if (comment != null && comment.trim().isNotEmpty)
        'comment': comment.trim(),
    });
  }

  /// Submit a "Join UDA" membership application.
  ///
  /// Uses multipart/form-data so the National ID photos can be attached.
  Future<void> submitMembership({
    required Map<String, String> fields,
    String? idFrontPath,
    String? idBackPath,
  }) async {
    final uri = Uri.parse('$baseUrl/members');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Accept'] = 'application/json'
      ..fields.addAll(fields);

    if (idFrontPath != null && idFrontPath.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath('id_front', idFrontPath),
      );
    }
    if (idBackPath != null && idBackPath.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath('id_back', idBackPath),
      );
    }

    http.StreamedResponse response;
    try {
      response = await request.send().timeout(const Duration(seconds: 30));
    } on TimeoutException {
      throw const ApiException(
        'Could not reach the UDA server. Please check your connection and '
        'that the backend is running, then try again.',
      );
    } catch (e) {
      throw ApiException(
        'Could not connect to the UDA server at $baseUrl. '
        'Make sure the backend is running and reachable from your phone.',
      );
    }

    final text = await response.stream.bytesToString();
    if (response.statusCode < 200 || response.statusCode >= 300) {
      String message = 'Submission failed (${response.statusCode})';
      try {
        final decoded = jsonDecode(text);
        if (decoded is Map) {
          if (decoded['errors'] is Map) {
            message = (decoded['errors'] as Map).values
                .expand((v) => v is List ? v : [v])
                .join('\n');
          } else if (decoded['message'] != null) {
            message = decoded['message'].toString();
          }
        }
      } catch (_) {}
      throw ApiException(message);
    }
  }

  Map<String, String>? _settingsCache;

  /// App settings (About text, contact info, Live TV, socials) managed from the
  /// admin dashboard. Cached for the session; pass [refresh] to force a reload.
  Future<Map<String, String>> getSettings({bool refresh = false}) async {
    if (_settingsCache != null && !refresh) return _settingsCache!;
    try {
      final data = await _request('GET', 'settings');
      if (data is Map) {
        _settingsCache = data.map(
          (k, v) => MapEntry(k.toString(), (v ?? '').toString()),
        );
        return _settingsCache!;
      }
    } catch (_) {
      // fall through to empty map
    }
    return _settingsCache ?? <String, String>{};
  }

  /// Fetch the signed-in user's profile.
  Future<Map<String, dynamic>> getProfile() async {
    final data = await _request('GET', 'me');
    final map = data is Map ? Map<String, dynamic>.from(data) : null;
    final user = map?['user'];
    if (user is! Map) {
      throw const ApiException('Could not load your profile.');
    }
    return Map<String, dynamic>.from(user);
  }

  /// Update the signed-in user's profile. Uses multipart so an avatar image
  /// can be attached. Returns the updated user.
  Future<Map<String, dynamic>> updateProfile({
    required Map<String, String> fields,
    String? avatarPath,
    bool removeAvatar = false,
  }) async {
    final uri = Uri.parse('$baseUrl/me');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Accept'] = 'application/json'
      ..fields.addAll(fields);

    if (_token != null && _token!.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $_token';
    }
    if (removeAvatar) {
      request.fields['remove_avatar'] = '1';
    }
    if (avatarPath != null && avatarPath.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath('avatar', avatarPath),
      );
    }

    http.StreamedResponse response;
    try {
      response = await request.send().timeout(const Duration(seconds: 30));
    } on TimeoutException {
      throw const ApiException(
        'Could not reach the UDA server. Please check your connection and '
        'that the backend is running, then try again.',
      );
    } catch (e) {
      throw ApiException(
        'Could not connect to the UDA server at $baseUrl. '
        'Make sure the backend is running and reachable from your phone.',
      );
    }

    final text = await response.stream.bytesToString();
    final decoded = text.isEmpty ? null : jsonDecode(text);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      String message = 'Update failed (${response.statusCode})';
      if (decoded is Map) {
        if (decoded['errors'] is Map) {
          message = (decoded['errors'] as Map).values
              .expand((v) => v is List ? v : [v])
              .join('\n');
        } else if (decoded['message'] != null) {
          message = decoded['message'].toString();
        }
      }
      throw ApiException(message);
    }

    final user = decoded is Map ? decoded['user'] : null;
    if (user is! Map) {
      throw const ApiException('The server returned an unexpected response.');
    }
    return Map<String, dynamic>.from(user);
  }
}

/// Custom exception used by the API service.
class ApiException implements Exception {
  final String message;

  const ApiException(this.message);

  @override
  String toString() => message;
}
