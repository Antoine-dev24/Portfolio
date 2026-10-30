import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/app_router.dart';
import '../theme/app_theme.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key, required this.currentPath});

  final String currentPath;

  // Un menu sans path reste inactif tant que sa page n'existe pas.
  static const _menus = [
    (label: 'Accueil', path: AppRoutes.home),
    (label: 'Projets', path: null),
    (label: 'Contact', path: null),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (final menu in _menus)
            _TopBarItem(
              label: menu.label,
              isActive: menu.path == currentPath,
              onPressed: switch (menu.path) {
                final String path => () => context.go(path),
                null => null,
              },
            ),
        ],
      ),
    );
  }
}

class _TopBarItem extends StatelessWidget {
  const _TopBarItem({
    required this.label,
    required this.isActive,
    required this.onPressed,
  });

  final String label;
  final bool isActive;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: isActive ? AppColors.orchid : AppColors.moonlight,
          disabledForegroundColor: AppColors.haze,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
