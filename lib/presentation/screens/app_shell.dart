import 'package:flutter/material.dart';

import '../widgets/night_sky_background.dart';
import '../widgets/top_bar.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.currentPath, required this.child});

  final String currentPath;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Le contenu défile sous la topbar pour que le flou soit visible.
      extendBodyBehindAppBar: true,
      appBar: TopBar(currentPath: currentPath),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const NightSkyBackground(),
          SafeArea(top: false, child: child),
        ],
      ),
    );
  }
}
