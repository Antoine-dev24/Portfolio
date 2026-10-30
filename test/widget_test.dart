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
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Laravel'), findsOneWidget);
  });
}
