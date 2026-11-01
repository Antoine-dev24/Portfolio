import 'experience.dart';

/// Les technos utilisées dans au moins une même expérience que [skillId].
Set<String> relatedSkillIds(String skillId, Iterable<Experience> experiences) {
  return {
    for (final experience in experiences)
      if (experience.usesSkill(skillId)) ...experience.skillIds,
  }..remove(skillId);
}
