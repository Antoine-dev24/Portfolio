import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

const _presentation =
    "Développeur fullstack depuis près de 5 ans, je crée et fais évoluer des "
    "applications métier avec Angular et Spring Boot, du développement jusqu'à "
    "la mise en production. Après huit ans dans le support technique, je me "
    "suis formé au développement en autodidacte, puis j'ai obtenu le titre de "
    "Concepteur Développeur d'Applications. Autonome et curieux, j'explore "
    "aujourd'hui Flutter sur mes projets personnels.";

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isCompact = MediaQuery.sizeOf(context).width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: ShaderMask(
            shaderCallback: const LinearGradient(
              colors: [
                AppColors.moonlight,
                AppColors.orchid,
                AppColors.lagoon,
              ],
            ).createShader,
            child: Text(
              'Antoine Moreno',
              textAlign: TextAlign.center,
              style: textTheme.displayLarge?.copyWith(
                color: Colors.white,
                fontSize: isCompact ? 48 : null,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            'Développeur fullstack Angular et Spring Boot',
            textAlign: TextAlign.center,
            style: textTheme.titleLarge?.copyWith(color: AppColors.lagoon),
          ),
        ),
        const SizedBox(height: 40),
        Text(_presentation, style: textTheme.bodyLarge),
      ],
    );
  }
}
