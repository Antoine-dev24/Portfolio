import 'package:flutter/material.dart';

import '../domain/experience.dart';
import '../../../core/theme/app_theme.dart';

class CareerStep extends StatelessWidget {
  const CareerStep({super.key, required this.experience});

  final Experience experience;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: AppColors.orchid.withValues(alpha: 0.5),
            width: 2,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              experience.period,
              style: textTheme.bodyMedium?.copyWith(color: AppColors.orchid),
            ),
            const SizedBox(height: 4),
            Text(
              experience.title,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              experience.details,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.haze,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
