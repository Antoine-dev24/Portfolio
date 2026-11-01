enum SkillCategory {
  frameworks,
  testing,
  languages,
  databases,
  devOpsCloud,
  mobile,
}

class Skill {
  const Skill({required this.id, required this.name, required this.categories});

  final String id;
  final String name;
  // Une techno peut appartenir à plusieurs catégories (Flutter : framework et mobile).
  final Set<SkillCategory> categories;
}
