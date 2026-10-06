import 'package:flutter_test/flutter_test.dart';

import 'package:product_preview/main.dart';

void main() {
  testWidgets('App starts', (WidgetTester tester) async {
    await tester.pumpWidget(const ProductPreviewApp());
    expect(find.text('Product Preview'), findsOneWidget);
  });
}
