import '../domain/skill.dart';

const skills = [
  Skill(
    id: 'spring-boot',
    name: 'Spring Boot',
    categories: {SkillCategory.frameworks},
  ),
  Skill(id: 'angular', name: 'Angular', categories: {SkillCategory.frameworks}),
  Skill(
    id: 'angularjs',
    name: 'AngularJS',
    categories: {SkillCategory.frameworks},
  ),
  Skill(id: 'nestjs', name: 'NestJS', categories: {SkillCategory.frameworks}),
  Skill(
    id: 'flutter',
    name: 'Flutter',
    categories: {SkillCategory.frameworks, SkillCategory.mobile},
  ),
  Skill(
    id: 'android-studio',
    name: 'Android Studio',
    categories: {SkillCategory.mobile},
  ),
  // Testing
  Skill(id: 'junit', name: 'Junit', categories: {SkillCategory.testing}),
  Skill(id: 'jest', name: 'Jest', categories: {SkillCategory.testing}),
  Skill(id: 'jasmine', name: 'Jasmine', categories: {SkillCategory.testing}),
  Skill(id: 'spock', name: 'Spock', categories: {SkillCategory.testing}),
  // Languages
  Skill(id: 'java', name: 'Java', categories: {SkillCategory.languages}),
  Skill(id: 'typescript', name: 'Typescript', categories: {SkillCategory.languages}),
  Skill(id: 'kotlin', name: 'Kotlin', categories: {SkillCategory.languages}),
  Skill(id: 'javascript', name: 'Javascript', categories: {SkillCategory.languages}),
  Skill(id: 'dart', name: 'Dart', categories: {SkillCategory.languages}),
  // Databases
  Skill(id: 'mariadb', name: 'MariaDB', categories: {SkillCategory.databases}),
  Skill(
    id: 'postgresql',
    name: 'PostgreSQL',
    categories: {SkillCategory.databases},
  ),
  Skill(id: 'docker', name: 'Docker', categories: {SkillCategory.devOpsCloud}),
  Skill(
    id: 'kubernetes',
    name: 'Kubernetes',
    categories: {SkillCategory.devOpsCloud},
  ),
  Skill(id: 'gcp', name: 'GCP', categories: {SkillCategory.devOpsCloud}),
];
