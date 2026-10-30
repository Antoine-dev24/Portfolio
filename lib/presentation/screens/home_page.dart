import 'package:flutter/material.dart';

const _welcome =
    "Je suis Antoine Moreno, développeur fullstack. Sur ce portfolio, vous "
    "pouvez découvrir mon parcours et les technologies avec lesquelles je "
    "travaille.";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isCompact = MediaQuery.sizeOf(context).width < 600;

    return Center(
      child: SingleChildScrollView(
        // Le padding haut de MediaQuery inclut la hauteur de la topbar.
        padding: EdgeInsets.fromLTRB(
          24,
          MediaQuery.paddingOf(context).top + 48,
          24,
          64,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Bienvenue',
                textAlign: TextAlign.center,
                style: textTheme.displayLarge?.copyWith(
                  fontSize: isCompact ? 48 : null,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                _welcome,
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
