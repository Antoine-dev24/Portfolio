import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app_router.dart';
import '../../app_theme.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key, required this.currentPath});

  final String currentPath;

  static const _height = 72.0;

  @override
  Size get preferredSize => const Size.fromHeight(_height);

  // Un menu sans path reste inactif tant que sa page n'existe pas.
  static const _menus = [
    (label: 'Accueil', path: AppRoutes.home),
    (label: 'Parcours', path: AppRoutes.career),
    (label: 'Projets', path: null),
    (label: 'Contact', path: null),
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.moonlight.withValues(alpha: 0.06),
            border: Border(
              bottom: BorderSide(
                color: AppColors.moonlight.withValues(alpha: 0.14),
              ),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: SizedBox(
              height: _height,
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
            ),
          ),
        ),
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
