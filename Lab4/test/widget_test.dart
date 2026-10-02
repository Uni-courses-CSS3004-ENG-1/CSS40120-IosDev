import 'package:flutter_test/flutter_test.dart';

import 'package:profile_card/main.dart';

void main() {
  testWidgets('App shows the profile screen', (tester) async {
    await tester.pumpWidget(const ProfileApp());

    expect(find.text('Profile'), findsOneWidget);
  });
}
