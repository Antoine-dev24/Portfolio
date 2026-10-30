import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/framework.dart';
import 'store_state.dart';

// Fake store : données en dur, à remplacer plus tard par une vraie source.
class StoreCubit extends Cubit<StoreState> {
  StoreCubit()
    : super(
        const StoreState(
          frameworks: [
            Framework(id: 1, name: 'Flutter'),
            Framework(id: 2, name: 'React'),
            Framework(id: 3, name: 'Vue.js'),
            Framework(id: 4, name: 'Angular'),
            Framework(id: 5, name: 'Laravel'),
          ],
        ),
      );
}
