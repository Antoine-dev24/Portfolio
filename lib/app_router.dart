import 'package:go_router/go_router.dart';

import 'presentation/screens/app_shell.dart';
import 'presentation/screens/career_page.dart';
import 'presentation/screens/home_page.dart';

abstract final class AppRoutes {
  static const home = '/';
  static const career = '/parcours';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    // Le ShellRoute affiche la topbar et le fond autour de toutes les pages.
    ShellRoute(
      builder: (context, state, child) =>
          AppShell(currentPath: state.uri.path, child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomePage()),
        ),
        GoRoute(
          path: AppRoutes.career,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: CareerPage()),
        ),
      ],
    ),
  ],
);
