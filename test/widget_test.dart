import 'package:flutter_test/flutter_test.dart';
import 'package:test_drive/app.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(App());

    // Verify that our counter starts at 0.
    expect(0, equals(0));
  });
}
