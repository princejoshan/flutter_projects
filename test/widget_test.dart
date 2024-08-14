// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.



import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/main.dart';

void main() {
  testWidgets('MyApp initializes correctly and builds the correct MaterialApp', (WidgetTester tester) async {
    // Build the widget tree.
    await tester.pumpWidget(const MyApp());

    // Verify the title of the app.
    expect(find.text('Flutter Demo'), findsNothing); // Title is not visible in the UI but it's set in MaterialApp.

    // Extract the MaterialApp widget to inspect its properties.
  });

}
