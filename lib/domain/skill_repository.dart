import 'skill.dart';

abstract interface class SkillRepository {
  Future<List<Skill>> getAll();
}
