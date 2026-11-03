import '../domain/experience.dart';

const experiences = [
  Experience(
    label: 'Projets personnels',
    period: 'Depuis octobre 2026',
    title: 'Découverte du framework Flutter',
    details: [
      'Conception et développement de ce portfolio en Flutter Web et Dart',
      'Architecture hexagonale : séparation domaine, application et '
          'infrastructure',
      'Interfaces responsives avec Material 3 et composition de widgets',
      'Gestion d\'état avec Cubit (state/store) et états immuables',
      'Pattern matching Dart 3 : sealed classes, switch expressions',
    ],
    skillIds: ['flutter', 'dart', 'android-studio'],
  ),
  Experience(
    label: 'SII',
    period: 'Depuis septembre 2025',
    title: 'Développeur fullstack, SII Nouvelle-Aquitaine',
    details: [
      "Maintenance et évolution d'une quinzaine d'applications Spring Boot",
      'Montées de version de Spring Boot 2 à 4',
      'Administration MariaDB',
      'Suivi de production sur datacenter auto-hébergé',
      'Veille sécuritaire pour résoudre des failles de sécurité',
      'Automatisation des tests fonctionnels via script python/bash',
    ],
    skillIds: ['spring-boot', 'mariadb', 'python', 'bash', 'java', 'junit'],
  ),
  Experience(
    label: 'E-Cervo',
    period: '2022 à 2025',
    title: 'Développeur fullstack, E-Cervo, Montpellier',
    details: [
      'Projet 1 : Développement d\'une application de reprographie avec gestion de factures et d\'un module de templating de documents',
      'Spring boot / Java, Docker, Kubernetes, NestJS, Angular, AngularJS',
      'Projet 2 : Logiciel de workflow métier interfacé sur une GED DocuShare',
      'Spring boot (kotlin), Angular, Docker'
      'Conteneurisation Docker',
      'Déploiement sur GCP avec Kubernetes',
    ],
    skillIds: [
      'spring-boot',
      'java',
      'kotlin',
      'angular',
      'angularjs',
      'postgresql',
      'docker',
      'kubernetes',
      'gcp',
      'material',
      'nestjs',
      'jest',
      'jasmine',
      'spock',
      'junit',
      'typescript',
      'javascript',
    ],
  ),
  Experience(
    label: 'AFPA',
    period: '2021',
    title: "Concepteur Développeur d'Applications, AFPA",
    details: [
      'Titre professionnel obtenu à Saint-Jean-de-Védas, après deux ans de '
          'formation autodidacte',
    ],
  ),
  Experience(
    label: 'Support technique',
    period: '2012 à 2020',
    title: 'Technicien support N2',
    details: [
      'Support itinérant et hotline auprès de commissaires de justice et de '
          'notaires',
      'Formation des utilisateurs',
    ],
  ),
];
