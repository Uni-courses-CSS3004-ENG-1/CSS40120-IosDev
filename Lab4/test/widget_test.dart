import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:profile_card/main.dart';

void main() {
  testWidgets('App shows the profile screen', (tester) async {
    await tester.pumpWidget(const ProfileApp());

    expect(find.text('Profile'), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.text('Abror'), findsOneWidget);
    expect(find.text('Flutter & iOS Developer'), findsOneWidget);
  });
}
