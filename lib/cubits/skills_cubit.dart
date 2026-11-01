import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/skill.dart';
import '../domain/skill_repository.dart';
import 'skills_state.dart';

class SkillsCubit extends Cubit<SkillsState> {
  SkillsCubit(this._repository) : super(const SkillsLoading());

  final SkillRepository _repository;

  Future<void> load() async {
    SkillsState next;
    try {
      next = SkillsLoaded(skills: await _repository.getAll());
    } on Exception {
      next = const SkillsError();
    }
    // L'utilisateur a pu quitter la page pendant le chargement.
    if (!isClosed) emit(next);
  }

  void selectCategory(SkillCategory? category) {
    final current = state;
    if (current is! SkillsLoaded) return;

    // Une techno masquée par le filtre ne doit pas rester sélectionnée.
    final selected = current.selectedSkill;
    final staysVisible =
        category == null || (selected?.categories.contains(category) ?? false);

    emit(
      SkillsLoaded(
        skills: current.skills,
        selectedCategory: category,
        selectedSkill: staysVisible ? selected : null,
      ),
    );
  }

  void toggleSkill(Skill skill) {
    final current = state;
    if (current is! SkillsLoaded) return;

    emit(
      SkillsLoaded(
        skills: current.skills,
        selectedCategory: current.selectedCategory,
        selectedSkill: current.selectedSkill?.id == skill.id ? null : skill,
      ),
    );
  }
}
