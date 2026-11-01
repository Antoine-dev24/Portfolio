import 'package:flutter/material.dart';

import '../../../domain/experience.dart';
import '../../../app_theme.dart';

class CareerMenu extends StatelessWidget {
  const CareerMenu({
    super.key,
    required this.experiences,
    required this.activeIndex,
    required this.onSelected,
  });

  final List<Experience> experiences;
  final int activeIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        24,
        MediaQuery.paddingOf(context).top + 48,
        0,
        24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (index, experience) in experiences.indexed)
            _CareerMenuItem(
              label: experience.label,
              period: experience.period,
              isActive: index == activeIndex,
              onTap: () => onSelected(index),
            ),
          // La stack prend l'index qui suit la dernière expérience.
          _CareerMenuItem(
            label: 'Stack technique',
            period: 'Technologies et outils',
            isActive: activeIndex == experiences.length,
            onTap: () => onSelected(experiences.length),
          ),
        ],
      ),
    );
  }
}

class _CareerMenuItem extends StatelessWidget {
  const _CareerMenuItem({
    required this.label,
    required this.period,
    required this.isActive,
    required this.onTap,
  });

  static const _duration = Duration(milliseconds: 200);

  final String label;
  final String period;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      selected: isActive,
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: _duration,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.orchid.withValues(alpha: 0.10)
                : Colors.transparent,
            border: Border(
              left: BorderSide(
                color: isActive
                    ? AppColors.orchid
                    : AppColors.moonlight.withValues(alpha: 0.14),
                width: 2,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedDefaultTextStyle(
                duration: _duration,
                style: textTheme.titleSmall!.copyWith(
                  color: isActive ? AppColors.orchid : AppColors.moonlight,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                ),
                child: Text(label),
              ),
              const SizedBox(height: 2),
              Text(
                period,
                style: textTheme.bodySmall?.copyWith(color: AppColors.haze),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
