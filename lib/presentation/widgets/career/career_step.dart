import 'package:flutter/material.dart';

import '../../../domain/experience.dart';
import '../../../app_theme.dart';

class CareerStep extends StatelessWidget {
  const CareerStep({
    super.key,
    required this.experience,
    this.isHighlighted = false,
    this.isDimmed = false,
  });

  static const _duration = Duration(milliseconds: 350);

  final Experience experience;
  final bool isHighlighted;
  final bool isDimmed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AnimatedOpacity(
      duration: _duration,
      opacity: isDimmed ? 0.4 : 1,
      child: AnimatedContainer(
        duration: _duration,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: isHighlighted
                  ? AppColors.lagoon
                  : AppColors.orchid.withValues(alpha: 0.5),
              width: 2,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    experience.title,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    experience.period,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.orchid,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              for (final detail in experience.details)
                Text(
                  '• $detail',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.haze,
                    height: 1.5,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
