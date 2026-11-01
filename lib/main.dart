import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_router.dart';
import 'app_theme.dart';
import 'domain/experience_repository.dart';
import 'domain/skill_repository.dart';
import 'infrastructure/in_memory_experience_repository.dart';
import 'infrastructure/in_memory_skill_repository.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ExperienceRepository>(
          create: (_) => InMemoryExperienceRepository(),
        ),
        RepositoryProvider<SkillRepository>(
          create: (_) => InMemorySkillRepository(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Portfolio',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        routerConfig: appRouter,
      ),
    );
  }
}
