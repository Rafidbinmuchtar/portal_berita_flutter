import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rekomendasi_musik/main.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Rekomendasi Musik'), findsOneWidget);
  });
}