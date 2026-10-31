import '../domain/experience.dart';
import '../domain/experience_repository.dart';
import 'experiences.dart';

class InMemoryExperienceRepository implements ExperienceRepository {
  @override
  Future<List<Experience>> getAll() async => experiences;
}
