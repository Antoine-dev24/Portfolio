import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/framework.dart';
import 'frameworks_state.dart';

// Données factices : en dur, à remplacer plus tard par une vraie source.
class FrameworksCubit extends Cubit<FrameworksState> {
  FrameworksCubit()
    : super(
        const FrameworksState(
          frameworks: [
            Framework(id: 1, name: 'Angular'),
            Framework(id: 2, name: 'Spring Boot'),
            Framework(id: 3, name: 'AngularJS'),
            Framework(id: 4, name: 'NestJS'),
            Framework(id: 5, name: 'Flutter'),
          ],
        ),
      );
}
