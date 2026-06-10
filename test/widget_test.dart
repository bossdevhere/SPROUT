import 'package:flutter_test/flutter_test.dart';
import 'package:sprout/main.dart';

void main() {
  testWidgets('App starts and shows Sprout', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SproutApp());

    // Verify that the app shows the name Sprout.
    expect(find.text('Sprout'), findsOneWidget);
  });
}
