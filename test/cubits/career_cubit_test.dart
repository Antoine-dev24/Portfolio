import 'package:flutter_test/flutter_test.dart';

import 'package:portfolio/cubits/career_cubit.dart';
import 'package:portfolio/cubits/career_state.dart';
import 'package:portfolio/domain/experience.dart';
import 'package:portfolio/domain/experience_repository.dart';

class _FakeExperienceRepository implements ExperienceRepository {
  _FakeExperienceRepository(this._getAll);

  final Future<List<Experience>> Function() _getAll;

  @override
  Future<List<Experience>> getAll() => _getAll();
}

void main() {
  test('load émet les expériences du repository', () async {
    const experience = Experience(
      label: 'SII',
      period: '2025',
      title: 'Développeur',
      details: ['Spring Boot'],
    );
    final cubit = CareerCubit(
      _FakeExperienceRepository(() async => [experience]),
    );
    addTearDown(cubit.close);

    expect(cubit.state, isA<CareerLoading>());

    await cubit.load();

    final state = cubit.state;
    expect(state, isA<CareerLoaded>());
    expect((state as CareerLoaded).experiences, [experience]);
  });

  test('load émet une erreur si le repository échoue', () async {
    final cubit = CareerCubit(
      _FakeExperienceRepository(() async => throw Exception('indisponible')),
    );
    addTearDown(cubit.close);

    await cubit.load();

    expect(cubit.state, isA<CareerError>());
  });
}
