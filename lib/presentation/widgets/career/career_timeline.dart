import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/skills_cubit.dart';
import '../../../cubits/skills_state.dart';
import '../../../domain/experience.dart';
import 'career_step.dart';

/// Les expériences, avec celles de la techno sélectionnée mises en avant.
class CareerTimeline extends StatelessWidget {
  const CareerTimeline({
    super.key,
    required this.experiences,
    required this.stepKeys,
  });

  final List<Experience> experiences;
  final List<GlobalKey> stepKeys;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SkillsCubit, SkillsState, String?>(
      selector: (state) =>
          state is SkillsLoaded ? state.selectedSkill?.id : null,
      builder: (context, skillId) {
        // Sans expérience associée, estomper tout le parcours n'apporterait rien.
        final hasMatch =
            skillId != null &&
            experiences.any((experience) => experience.usesSkill(skillId));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final (index, experience) in experiences.indexed)
              CareerStep(
                key: stepKeys[index],
                experience: experience,
                isHighlighted: hasMatch && experience.usesSkill(skillId),
                isDimmed: hasMatch && !experience.usesSkill(skillId),
              ),
          ],
        );
      },
    );
  }
}
