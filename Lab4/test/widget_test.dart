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
    expect(find.text('1240'), findsOneWidget);
    expect(find.text('87'), findsOneWidget);
  });

  testWidgets('Follow toggles between Follow and Following', (tester) async {
    await tester.pumpWidget(const ProfileApp());

    expect(find.text('Follow'), findsOneWidget);
    expect(find.text('1240'), findsOneWidget);

    await tester.tap(find.byKey(const Key('followButton')));
    await tester.pump();
    expect(find.text('Following'), findsOneWidget);
    expect(find.text('1241'), findsOneWidget);

    await tester.tap(find.byKey(const Key('followButton')));
    await tester.pump();
    expect(find.text('Follow'), findsOneWidget);
    expect(find.text('1240'), findsOneWidget);
  });

  testWidgets('Like increments and decrements counter', (tester) async {
    await tester.pumpWidget(const ProfileApp());

    expect(find.text('87'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);

    await tester.tap(find.byKey(const Key('likeButton')));
    await tester.pump();
    expect(find.text('88'), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    await tester.tap(find.byKey(const Key('likeButton')));
    await tester.pump();
    expect(find.text('87'), findsOneWidget);
  });
}
