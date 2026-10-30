import 'experience.dart';

abstract interface class ExperienceRepository {
  Future<List<Experience>> getAll();
}
