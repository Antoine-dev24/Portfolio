import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/skills_cubit.dart';
import '../../../cubits/skills_state.dart';
import '../../../domain/experience.dart';
import '../../../domain/skill_links.dart';
import 'skill_category_filter.dart';
import 'skill_category_grid.dart';
import 'skill_usage_banner.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({
    super.key,
    required this.experiences,
    required this.onShowExperience,
  });

  final List<Experience> experiences;
  final ValueChanged<int> onShowExperience;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Stack technique', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 20),
        BlocBuilder<SkillsCubit, SkillsState>(
          builder: (context, state) => switch (state) {
            SkillsLoading() => const Center(child: CircularProgressIndicator()),
            SkillsLoaded() => _SkillsContent(
              state: state,
              experiences: experiences,
              onShowExperience: onShowExperience,
            ),
            SkillsError() => const Text('Impossible de charger la stack.'),
          },
        ),
      ],
    );
  }
}

class _SkillsContent extends StatelessWidget {
  const _SkillsContent({
    required this.state,
    required this.experiences,
    required this.onShowExperience,
  });

  final SkillsLoaded state;
  final List<Experience> experiences;
  final ValueChanged<int> onShowExperience;

  static const _usageMinHeight = 88.0;

  @override
  Widget build(BuildContext context) {
    final selected = state.selectedSkill;
    final linkedIds = selected == null
        ? const <String>{}
        : relatedSkillIds(selected.id, experiences);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkillCategoryFilter(
          selected: state.selectedCategory,
          onSelected: context.read<SkillsCubit>().selectCategory,
        ),
        const SizedBox(height: 16),
        // La hauteur réservée évite que les cartes bougent sous le curseur.
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: _usageMinHeight),
          child: selected == null
              ? Text(
                  'Clique sur une techno pour voir où je l\'ai utilisée.',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              : SkillUsageBanner(
                  skill: selected,
                  experiences: experiences,
                  onShowExperience: onShowExperience,
                ),
        ),
        const SizedBox(height: 8),
        AnimatedSize(
          duration: MediaQuery.disableAnimationsOf(context)
              ? Duration.zero
              : const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          // Laisse la carte survolée dépasser légèrement vers le haut.
          clipBehavior: Clip.none,
          child: SkillCategoryGrid(state: state, linkedSkillIds: linkedIds),
        ),
      ],
    );
  }
}
