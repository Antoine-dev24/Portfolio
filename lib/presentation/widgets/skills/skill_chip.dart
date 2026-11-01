import 'package:flutter/material.dart';

import '../../../app_theme.dart';
import '../../../domain/skill.dart';
import 'skill_visuals.dart';

class SkillChip extends StatelessWidget {
  const SkillChip({
    super.key,
    required this.skill,
    required this.isSelected,
    required this.isLinked,
    required this.isDimmed,
    required this.onPressed,
  });

  final Skill skill;
  final bool isSelected;
  final bool isLinked;
  final bool isDimmed;
  final VoidCallback onPressed;

  Color get _accent {
    if (isSelected) return AppColors.orchid;
    return isLinked ? AppColors.lagoon : AppColors.moonlight;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isDimmed ? 0.45 : 1,
      child: FilterChip(
        avatar: Icon(skillIcon(skill.id), size: 16, color: _accent),
        label: Text(skill.name),
        selected: isSelected,
        showCheckmark: false,
        onSelected: (_) => onPressed(),
        backgroundColor: AppColors.midnight.withValues(alpha: 0.45),
        selectedColor: AppColors.orchid.withValues(alpha: 0.2),
        side: BorderSide(
          color: isSelected || isLinked
              ? _accent
              : AppColors.lagoon.withValues(alpha: 0.4),
        ),
        shape: const StadiumBorder(),
      ),
    );
  }
}
