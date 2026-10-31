import '../domain/experience.dart';

const experiences = [
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
      'Automatisation des tests fonctionnels via script python/bash'
    ],
  ),
  Experience(
    label: 'E-Cervo',
    period: '2022 à 2025',
    title: 'Développeur fullstack, E-Cervo, Montpellier',
    details: [
      'Développement de deux applications métier avec Spring, Kotlin, Angular '
          'et PostgreSQL',
      'Conteneurisation Docker',
      'Déploiement sur GCP avec Kubernetes',
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
