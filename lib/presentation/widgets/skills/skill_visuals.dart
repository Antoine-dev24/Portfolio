import 'package:flutter/material.dart';
import 'package:simple_icons/simple_icons.dart';

import '../../../domain/skill.dart';

// Les libellés et les icônes relèvent de l'affichage : le domaine les ignore.
extension SkillCategoryVisuals on SkillCategory {
  String get label => switch (this) {
    SkillCategory.frameworks => 'Frameworks',
    SkillCategory.testing => 'Testing',
    SkillCategory.languages => 'Langages',
    SkillCategory.databases => 'Bases de données',
    SkillCategory.devOpsCloud => 'DevOps & Cloud',
    SkillCategory.mobile => 'Mobile',
  };

  IconData get icon => switch (this) {
    SkillCategory.frameworks => Icons.widgets_outlined,
    SkillCategory.testing => Icons.science_outlined,
    SkillCategory.languages => Icons.code,
    SkillCategory.databases => Icons.storage_outlined,
    SkillCategory.devOpsCloud => Icons.cloud_outlined,
    SkillCategory.mobile => Icons.smartphone,
  };
}

const _skillIcons = <String, IconData>{
  'angular': SimpleIcons.angular,
  'spring-boot': SimpleIcons.springboot,
  // Simple Icons ne propose pas de logo AngularJS.
  'angularjs': SimpleIcons.angular,
  'nestjs': SimpleIcons.nestjs,
  'flutter': SimpleIcons.flutter,
  'android-studio': SimpleIcons.androidstudio,
  'junit': SimpleIcons.junit5,
  'jest': SimpleIcons.jest,
  'jasmine': SimpleIcons.jasmine,
  // Simple Icons ne propose pas de logo Spock : on prend celui de Groovy, son langage.
  'spock': SimpleIcons.apachegroovy,
  // Simple Icons ne propose pas de logo Java : on prend celui d'OpenJDK.
  'java': SimpleIcons.openjdk,
  'typescript': SimpleIcons.typescript,
  'javascript': SimpleIcons.javascript,
  'kotlin': SimpleIcons.kotlin,
  'python': SimpleIcons.python,
  'bash': SimpleIcons.gnubash,
  'dart': SimpleIcons.dart,
  'mariadb': SimpleIcons.mariadb,
  'postgresql': SimpleIcons.postgresql,
  'docker': SimpleIcons.docker,
  'kubernetes': SimpleIcons.kubernetes,
  'gcp': SimpleIcons.googlecloud,
};

IconData skillIcon(String skillId) =>
    _skillIcons[skillId] ?? Icons.star_outline;
