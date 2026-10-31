import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/experience_repository.dart';
import 'career_state.dart';

class CareerCubit extends Cubit<CareerState> {
  CareerCubit(this._repository) : super(const CareerLoading());

  final ExperienceRepository _repository;

  Future<void> load() async {
    CareerState next;
    try {
      next = CareerLoaded(await _repository.getAll());
    } on Exception {
      next = const CareerError();
    }
    // L'utilisateur a pu quitter la page pendant le chargement.
    if (!isClosed) emit(next);
  }
}
