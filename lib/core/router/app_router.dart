import 'package:go_router/go_router.dart';

import '../../features/home/presentation/home_page.dart';
import '../shell/app_shell.dart';

abstract final class AppRoutes {
  static const home = '/';
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
      ],
    ),
  ],
);
