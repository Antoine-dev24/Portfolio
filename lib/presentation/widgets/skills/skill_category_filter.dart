import 'package:flutter/material.dart';

import '../../../domain/skill.dart';
import 'skill_visuals.dart';

class SkillCategoryFilter extends StatelessWidget {
  const SkillCategoryFilter({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final SkillCategory? selected;
  final ValueChanged<SkillCategory?> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ChoiceChip(
          label: const Text('Tout'),
          selected: selected == null,
          onSelected: (_) => onSelected(null),
        ),
        for (final category in SkillCategory.values)
          ChoiceChip(
            label: Text(category.label),
            selected: selected == category,
            onSelected: (_) => onSelected(category),
          ),
      ],
    );
  }
}
