import 'package:flutter/material.dart';

import 'night_sky_background.dart';
import 'top_bar.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.currentPath, required this.child});

  final String currentPath;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const NightSkyBackground(),
          SafeArea(
            child: Column(
              children: [
                TopBar(currentPath: currentPath),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
