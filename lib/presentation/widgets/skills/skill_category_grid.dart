import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/skills_cubit.dart';
import '../../../cubits/skills_state.dart';
import '../../../domain/skill.dart';
import 'scroll_reveal.dart';
import 'skill_category_card.dart';
import 'skill_chip.dart';

class SkillCategoryGrid extends StatelessWidget {
  const SkillCategoryGrid({
    super.key,
    required this.state,
    required this.linkedSkillIds,
  });

  static const _spacing = 16.0;
  static const _twoColumnsMinWidth = 560.0;

  final SkillsLoaded state;
  final Set<String> linkedSkillIds;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final categories = state.visibleCategories;
        final isTwoColumns =
            categories.length > 1 &&
            constraints.maxWidth >= _twoColumnsMinWidth;
        final cardWidth = isTwoColumns
            ? (constraints.maxWidth - _spacing) / 2
            : constraints.maxWidth;

        return Wrap(
          spacing: _spacing,
          runSpacing: _spacing,
          children: [
            for (final category in categories)
              SizedBox(
                key: ValueKey(category),
                width: cardWidth,
                child: SkillCategoryCard(
                  category: category,
                  chips: _chipsOf(context, category),
                ),
              ),
          ],
        );
      },
    );
  }

  List<Widget> _chipsOf(BuildContext context, SkillCategory category) {
    final selectedId = state.selectedSkill?.id;

    return [
      for (final (index, skill) in state.skillsIn(category).indexed)
        ScrollReveal(
          key: ValueKey(skill.id),
          delay: Duration(milliseconds: 70 * index),
          child: SkillChip(
            skill: skill,
            isSelected: skill.id == selectedId,
            isLinked: linkedSkillIds.contains(skill.id),
            isDimmed:
                selectedId != null &&
                skill.id != selectedId &&
                !linkedSkillIds.contains(skill.id),
            onPressed: () => context.read<SkillsCubit>().toggleSkill(skill),
          ),
        ),
    ];
  }
}
