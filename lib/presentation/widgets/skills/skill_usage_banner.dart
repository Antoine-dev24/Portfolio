import 'package:flutter/material.dart';

import '../../../app_theme.dart';
import '../../../domain/experience.dart';
import '../../../domain/skill.dart';

/// Indique où la techno choisie a été utilisée et permet d'y remonter.
class SkillUsageBanner extends StatelessWidget {
  const SkillUsageBanner({
    super.key,
    required this.skill,
    required this.experiences,
    required this.onShowExperience,
  });

  final Skill skill;
  final List<Experience> experiences;
  final ValueChanged<int> onShowExperience;

  String get _message => switch (experiences
      .where((experience) => experience.usesSkill(skill.id))
      .length) {
    0 => '${skill.name} : aucune expérience détaillée dans ce parcours',
    1 => '${skill.name} : utilisé dans 1 expérience',
    final count => '${skill.name} : utilisé dans $count expériences',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _message,
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: AppColors.lagoon),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final (index, experience) in experiences.indexed)
              if (experience.usesSkill(skill.id))
                ActionChip(
                  avatar: const Icon(Icons.arrow_upward, size: 16),
                  label: Text(experience.label),
                  onPressed: () => onShowExperience(index),
                ),
          ],
        ),
      ],
    );
  }
}
