import '../domain/experience.dart';

sealed class CareerState {
  const CareerState();
}

final class CareerLoading extends CareerState {
  const CareerLoading();
}

final class CareerLoaded extends CareerState {
  const CareerLoaded(this.experiences);

  final List<Experience> experiences;
}

final class CareerError extends CareerState {
  const CareerError();
}
