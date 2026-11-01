import '../domain/skill.dart';
import '../domain/skill_repository.dart';
import 'skills.dart';

class InMemorySkillRepository implements SkillRepository {
  @override
  Future<List<Skill>> getAll() async => skills;
}
