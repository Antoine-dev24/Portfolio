import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'store_cubit.dart';
import '../../../core/theme/app_theme.dart';

class FrameworksSection extends StatelessWidget {
  const FrameworksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final frameworks = context.select(
      (StoreCubit cubit) => cubit.state.frameworks,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Frameworks', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final framework in frameworks)
              Chip(
                key: ValueKey(framework.id),
                label: Text(framework.name),
                backgroundColor: AppColors.midnight.withValues(alpha: 0.45),
                side: BorderSide(
                  color: AppColors.lagoon.withValues(alpha: 0.4),
                ),
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
