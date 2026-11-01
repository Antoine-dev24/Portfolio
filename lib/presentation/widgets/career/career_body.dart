import 'package:flutter/material.dart';

import '../../../domain/experience.dart';
import '../skills/skills_section.dart';
import 'career_header.dart';
import 'career_timeline.dart';

class CareerBody extends StatelessWidget {
  const CareerBody({
    super.key,
    required this.experiences,
    required this.stepKeys,
    required this.stackKey,
    required this.showStackShortcut,
    required this.onScrollTo,
  });

  final List<Experience> experiences;
  final List<GlobalKey> stepKeys;
  final GlobalKey stackKey;
  // Sans menu latéral, ce bouton reste le seul raccourci vers la stack.
  final bool showStackShortcut;
  final ValueChanged<int> onScrollTo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CareerHeader(),
        if (showStackShortcut) ...[
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () => onScrollTo(experiences.length),
            icon: const Icon(Icons.arrow_downward),
            label: const Text('Voir ma stack'),
          ),
        ],
        const SizedBox(height: 64),
        Text('Parcours', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 24),
        CareerTimeline(experiences: experiences, stepKeys: stepKeys),
        const SizedBox(height: 40),
        SkillsSection(
          key: stackKey,
          experiences: experiences,
          onShowExperience: onScrollTo,
        ),
      ],
    );
  }
}
