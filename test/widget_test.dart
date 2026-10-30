import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:portfolio/main.dart';

void main() {
  testWidgets('La route / affiche la topbar et les frameworks du store', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    for (final menu in ['Accueil', 'Projets', 'Contact']) {
      expect(find.text(menu), findsOneWidget);
    }
    expect(find.text('Antoine Moreno'), findsOneWidget);
    expect(find.text('Parcours'), findsOneWidget);
    expect(find.text('Spring Boot'), findsOneWidget);
    expect(find.text('Flutter'), findsOneWidget);
  });

  testWidgets('Le menu de gauche suit le scroll et amène à une expérience', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    bool isSelected(String label) => tester
        .widget<Semantics>(
          find
              .ancestor(
                of: find.text(label),
                matching: find.byWidgetPredicate(
                  (widget) =>
                      widget is Semantics && widget.properties.selected != null,
                ),
              )
              .first,
        )
        .properties
        .selected!;

    expect(isSelected('SII'), isTrue);

    await tester.tap(find.text('Support technique'));
    await tester.pumpAndSettle();

    final top = tester.getTopLeft(find.text('2012 à 2020').last).dy;
    expect(top, inInclusiveRange(72, 72 + 48));
    expect(isSelected('Support technique'), isTrue);
    expect(isSelected('SII'), isFalse);

    await tester.drag(
      find.text('Technicien support N2'),
      const Offset(0, 2000),
    );
    await tester.pumpAndSettle();

    expect(isSelected('SII'), isTrue);
  });
}
