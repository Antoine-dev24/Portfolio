import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../store/store_cubit.dart';
import '../theme/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final frameworks = context.select(
      (StoreCubit cubit) => cubit.state.frameworks,
    );
    final isCompact = MediaQuery.sizeOf(context).width < 600;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            children: [
              ShaderMask(
                shaderCallback: const LinearGradient(
                  colors: [
                    AppColors.moonlight,
                    AppColors.orchid,
                    AppColors.lagoon,
                  ],
                ).createShader,
                child: Text(
                  'Antoine Moreno',
                  textAlign: TextAlign.center,
                  style: textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontSize: isCompact ? 48 : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Bienvenue sur mon portfolio.',
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge,
              ),
              const SizedBox(height: 72),
              Text('Frameworks', style: textTheme.titleLarge),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final framework in frameworks)
                    Chip(
                      key: ValueKey(framework.id),
                      label: Text(framework.name),
                      backgroundColor: AppColors.midnight.withValues(
                        alpha: 0.45,
                      ),
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
          ),
        ),
      ),
    );
  }
}
