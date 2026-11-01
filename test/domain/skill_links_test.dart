import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/domain/experience.dart';
import 'package:portfolio/domain/skill_links.dart';
import 'package:portfolio/infrastructure/experiences.dart';
import 'package:portfolio/infrastructure/skills.dart';

Experience _experience(List<String> skillIds) => Experience(
  label: 'label',
  period: 'period',
  title: 'title',
  details: const [],
  skillIds: skillIds,
);

void main() {
  test('relatedSkillIds réunit les technos des expériences communes', () {
    final related = relatedSkillIds('a', [
      _experience(['a', 'b']),
      _experience(['a', 'c']),
      _experience(['d']),
    ]);

    expect(related, {'b', 'c'});
  });

  test('relatedSkillIds est vide pour une techno sans expérience', () {
    expect(
      relatedSkillIds('a', [
        _experience(['b']),
      ]),
      isEmpty,
    );
  });

  test('chaque expérience référence une techno qui existe', () {
    final knownIds = {for (final skill in skills) skill.id};

    for (final experience in experiences) {
      expect(knownIds, containsAll(experience.skillIds));
    }
  });
}
