import 'package:flutter/material.dart';

import '../../../app_theme.dart';
import '../../../domain/skill.dart';
import 'skill_visuals.dart';

class SkillCategoryCard extends StatefulWidget {
  const SkillCategoryCard({
    super.key,
    required this.category,
    required this.chips,
  });

  final SkillCategory category;
  final List<Widget> chips;

  @override
  State<SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<SkillCategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : const Duration(milliseconds: 180),
        transform: Matrix4.translationValues(0, _isHovered ? -4 : 0, 0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.aubergine.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.lagoon.withValues(alpha: _isHovered ? 0.8 : 0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CardTitle(category: widget.category),
            const SizedBox(height: 14),
            Wrap(spacing: 8, runSpacing: 8, children: widget.chips),
          ],
        ),
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle({required this.category});

  final SkillCategory category;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(category.icon, size: 20, color: AppColors.lagoon),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            category.label,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}
