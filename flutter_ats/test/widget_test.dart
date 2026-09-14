import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ats/main.dart';

void main() {
  testWidgets('Blog App test', (WidgetTester tester) async {
    await tester.pumpWidget(const BlogApp());

    expect(find.text('Blog App'), findsOneWidget);
  });
}