import 'dart:convert';

import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:http/http.dart' as http;

/// Single API boundary for the Flutter app.
///
/// Override the URL for a physical device with:
/// flutter run --dart-define=API_BASE_URL=http://192.168.1.10:8000/api
class ApiService {
  ApiService._();

  static final ApiService instance = ApiService._();
  static const _configuredUrl = String.fromEnvironment('API_BASE_URL');

  /// Chrome/desktop/iOS simulator can reach the host machine via localhost.
  /// Only the Android emulator needs the special 10.0.2.2 alias.
  static String get baseUrl {
    if (_configuredUrl.isNotEmpty) return _configuredUrl;
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:8000/api';
    }
    return 'http://127.0.0.1:8000/api';
  }

  String? _token;

  Map<String, String> get _headers => {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    if (_token != null) 'Authorization': 'Bearer $_token',
  };

  Future<dynamic> _request(
    String method,
    String path, [
    Map<String, dynamic>? body,
  ]) async {
    final uri = Uri.parse('$baseUrl/$path');
    final request = http.Request(method, uri)..headers.addAll(_headers);
    if (body != null) request.body = jsonEncode(body);
    final response = await request.send().timeout(const Duration(seconds: 15));
    final text = await response.stream.bytesToString();
    dynamic data;
    try {
      data = text.isEmpty ? null : jsonDecode(text);
    } catch (_) {
      data = text;
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final message = data is Map ? data['message'] : null;
      throw ApiException(
        message?.toString() ?? 'Request failed (${response.statusCode})',
      );
    }
    return data;
  }

  Future<List<Map<String, dynamic>>> getList(String resource) async {
    final data = await _request('GET', resource);
    final values = data is Map && data['data'] is List ? data['data'] : data;
    return (values as List)
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final data = Map<String, dynamic>.from(
      await _request('POST', 'login', {'email': email, 'password': password}),
    );
    _token = data['token']?.toString();
    return data;
  }

  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    final data = Map<String, dynamic>.from(
      await _request('POST', 'register', {
        'name': name,
        'email': email,
        'password': password,
      }),
    );
    _token = data['token']?.toString();
    return data;
  }

  Future<void> sendContact({
    required String name,
    required String email,
    String? subject,
    required String message,
  }) async {
    await _request('POST', 'contacts', {
      'name': name,
      'email': email,
      if (subject != null && subject.isNotEmpty) 'subject': subject,
      'message': message,
    });
  }

  Future<void> askQuestion({int? userId, required String question}) async {
    await _request('POST', 'questions', {
      if (userId != null) 'user_id': userId,
      'question_text': question,
    });
  }
}

class ApiException implements Exception {
  final String message;
  const ApiException(this.message);
  @override
  String toString() => message;
}
