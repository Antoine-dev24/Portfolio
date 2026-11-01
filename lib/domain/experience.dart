class Experience {
  const Experience({
    required this.label,
    required this.period,
    required this.title,
    required this.details,
    this.skillIds = const [],
  });

  final String label;
  final String period;
  final String title;
  final List<String> details;
  final List<String> skillIds;

  bool usesSkill(String skillId) => skillIds.contains(skillId);
}
