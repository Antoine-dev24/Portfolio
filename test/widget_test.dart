import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:portfolio/app_router.dart';
import 'package:portfolio/cubits/skills_cubit.dart';
import 'package:portfolio/infrastructure/experiences.dart';
import 'package:portfolio/infrastructure/in_memory_skill_repository.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/presentation/widgets/skills/skills_section.dart';

void main() {
  testWidgets('La route / affiche la topbar et la page d\'accueil', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PortfolioApp());
    appRouter.go(AppRoutes.home);
    await tester.pumpAndSettle();

    for (final menu in ['Accueil', 'Parcours', 'Projets', 'Contact']) {
      expect(find.text(menu), findsOneWidget);
    }
    expect(find.text('Bienvenue'), findsOneWidget);
    expect(find.text('Antoine Moreno'), findsNothing);
  });

  testWidgets('Le menu Parcours affiche le parcours et la stack', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PortfolioApp());
    appRouter.go(AppRoutes.home);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Parcours'));
    await tester.pumpAndSettle();

    expect(find.text('Antoine Moreno'), findsOneWidget);
    expect(find.text('Spring Boot'), findsOneWidget);
    // Flutter apparaît dans les cartes Frameworks et Mobile.
    expect(find.text('Flutter'), findsNWidgets(2));
  });

  testWidgets('Une techno relie la stack aux expériences du parcours', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const PortfolioApp());
    appRouter.go(AppRoutes.career);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Stack technique').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kotlin'));
    await tester.pumpAndSettle();

    expect(find.text('Kotlin : utilisé dans 1 expérience'), findsOneWidget);

    await tester.tap(find.widgetWithText(ActionChip, 'E-Cervo'));
    await tester.pumpAndSettle();

    final top = tester.getTopLeft(find.text('2022 à 2025').last).dy;
    expect(top, inInclusiveRange(72, 72 + 48));
  });

  testWidgets('Sans menu latéral, un bouton amène à la stack', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(700, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const PortfolioApp());
    appRouter.go(AppRoutes.career);
    await tester.pumpAndSettle();

    // Centré, pour que le bouton ne passe pas sous la topbar.
    await Scrollable.ensureVisible(
      tester.element(find.text('Voir ma stack')),
      alignment: 0.5,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Voir ma stack'));
    await tester.pumpAndSettle();

    final sectionTop = tester.getTopLeft(find.text('Stack technique')).dy;
    expect(sectionTop, inInclusiveRange(72, 72 + 48));
  });

  testWidgets('La stack ne déborde pas en largeur mobile', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider(
            create: (_) => SkillsCubit(InMemorySkillRepository())..load(),
            child: SingleChildScrollView(
              child: SkillsSection(
                experiences: experiences,
                onShowExperience: (_) {},
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Angular'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Angular'));
    await tester.pumpAndSettle();

    expect(find.text('Angular : utilisé dans 1 expérience'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Le filtre ne garde que la catégorie choisie', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const PortfolioApp());
    appRouter.go(AppRoutes.career);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Stack technique').first);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, 'Testing'));
    await tester.pumpAndSettle();

    expect(find.text('Jest'), findsOneWidget);
    expect(find.text('Kotlin'), findsNothing);
  });

  testWidgets('Le menu de gauche suit le scroll et amène à une expérience', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const PortfolioApp());
    appRouter.go(AppRoutes.career);
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
