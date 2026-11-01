import '../domain/skill.dart';

sealed class SkillsState {
  const SkillsState();
}

final class SkillsLoading extends SkillsState {
  const SkillsLoading();
}

final class SkillsLoaded extends SkillsState {
  const SkillsLoaded({
    required this.skills,
    this.selectedCategory,
    this.selectedSkill,
  });

  final List<Skill> skills;
  // null correspond au filtre « Tout ».
  final SkillCategory? selectedCategory;
  final Skill? selectedSkill;

  List<SkillCategory> get visibleCategories => [
    for (final category in SkillCategory.values)
      if ((selectedCategory ?? category) == category &&
          skillsIn(category).isNotEmpty)
        category,
  ];

  List<Skill> skillsIn(SkillCategory category) => [
    for (final skill in skills)
      if (skill.categories.contains(category)) skill,
  ];
}

final class SkillsError extends SkillsState {
  const SkillsError();
}
