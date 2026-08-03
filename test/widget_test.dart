import 'package:flutter_test/flutter_test.dart';

import 'package:uda_app/main.dart';

void main() {
  testWidgets('shows the splash screen and then the home screen', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('UNITED'), findsWidgets);
    expect(find.text('WELCOME'), findsNothing);

    await tester.pump(const Duration(seconds: 2));
    await tester.pump();

    expect(find.text('Welcome to UDA Party App'), findsOneWidget);
  });
}
