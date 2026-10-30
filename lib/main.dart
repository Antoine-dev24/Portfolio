import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/router/app_router.dart';
import 'features/frameworks/presentation/store_cubit.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoreCubit(),
      child: MaterialApp.router(
        title: 'Portfolio',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        routerConfig: appRouter,
      ),
    );
  }
}
