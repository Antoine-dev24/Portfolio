import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/cubits/skills_cubit.dart';
import 'package:portfolio/cubits/skills_state.dart';
import 'package:portfolio/domain/skill.dart';
import 'package:portfolio/domain/skill_repository.dart';

const _jest = Skill(
  id: 'jest',
  name: 'Jest',
  categories: {SkillCategory.testing},
);
const _flutter = Skill(
  id: 'flutter',
  name: 'Flutter',
  categories: {SkillCategory.frameworks, SkillCategory.mobile},
);

class _FakeSkillRepository implements SkillRepository {
  _FakeSkillRepository({this.fails = false});

  final bool fails;

  @override
  Future<List<Skill>> getAll() async {
    if (fails) throw Exception('indisponible');
    return const [_jest, _flutter];
  }
}

void main() {
  Future<SkillsCubit> loadedCubit() async {
    final cubit = SkillsCubit(_FakeSkillRepository());
    addTearDown(cubit.close);
    await cubit.load();
    return cubit;
  }

  SkillsLoaded loaded(SkillsCubit cubit) => cubit.state as SkillsLoaded;

  test('load passe en erreur si le repository échoue', () async {
    final cubit = SkillsCubit(_FakeSkillRepository(fails: true));
    addTearDown(cubit.close);

    await cubit.load();

    expect(cubit.state, isA<SkillsError>());
  });

  test('sans filtre, seules les catégories non vides sont visibles', () async {
    final cubit = await loadedCubit();

    expect(loaded(cubit).visibleCategories, [
      SkillCategory.frameworks,
      SkillCategory.testing,
      SkillCategory.mobile,
    ]);
  });

  test('toggleSkill sélectionne puis désélectionne la techno', () async {
    final cubit = await loadedCubit();

    cubit.toggleSkill(_jest);
    expect(loaded(cubit).selectedSkill, _jest);

    cubit.toggleSkill(_jest);
    expect(loaded(cubit).selectedSkill, isNull);
  });

  test('selectCategory retire une techno masquée par le filtre', () async {
    final cubit = await loadedCubit();
    cubit.toggleSkill(_jest);

    cubit.selectCategory(SkillCategory.mobile);

    expect(loaded(cubit).visibleCategories, [SkillCategory.mobile]);
    expect(loaded(cubit).selectedSkill, isNull);
  });

  test('selectCategory garde une techno encore visible', () async {
    final cubit = await loadedCubit();
    cubit.toggleSkill(_flutter);

    cubit.selectCategory(SkillCategory.mobile);
    expect(loaded(cubit).selectedSkill, _flutter);

    cubit.selectCategory(null);
    expect(loaded(cubit).selectedSkill, _flutter);
  });
}
