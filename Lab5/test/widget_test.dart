import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:product_preview/main.dart';

Future<void> openOnScreen(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const ProductPreviewApp());
}

void main() {
  // A RenderFlex overflow throws an error, so these tests fail if one happens
  testWidgets('No overflow on a small phone (iPhone SE)', (tester) async {
    await openOnScreen(tester, const Size(320, 568));
    expect(tester.takeException(), isNull);
  });

  testWidgets('No overflow on a large screen (iPad)', (tester) async {
    await openOnScreen(tester, const Size(1024, 1366));
    expect(tester.takeException(), isNull);
  });

  testWidgets('Bookmark badge toggles', (tester) async {
    await openOnScreen(tester, const Size(393, 852));

    await tester.tap(find.byIcon(Icons.bookmark_border));
    await tester.pump();
    expect(find.byIcon(Icons.bookmark), findsOneWidget);
  });

  testWidgets('Add to Cart counts the items in the cart', (tester) async {
    await openOnScreen(tester, const Size(393, 852));

    await tester.tap(find.text('Add to Cart'));
    await tester.tap(find.text('Add to Cart'));
    await tester.pump();
    expect(find.text('Added to cart'), findsOneWidget);
    expect(find.text('2'), findsOneWidget); // badge on the cart icon
  });
}
