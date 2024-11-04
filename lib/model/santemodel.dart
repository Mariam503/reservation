class HealthSubService {
  final String name;
  final String description;
  final String imagePath;

  HealthSubService({
    required this.name,
    required this.description,
    required this.imagePath,
  });
}

List<HealthSubService> healthSubServices = [
  HealthSubService(
    name: "Consultations Médicales",
    description: "Réservez avec divers spécialistes.",
    imagePath: "images/consultation.jpeg",
  ),
  HealthSubService(
    name: "Pharmacies",
    description: "Trouver des pharmacies ou commander en ligne.",
    imagePath: "images/pharmacie.jpeg",
  ),
  HealthSubService(
    name: "Urgences",
    description: "Accès aux centres d'urgence les plus proches.",
    imagePath: "images/urgence.jpeg",
  ),
  HealthSubService(
    name: "Médecine Alternative",
    description: "Réservez des séances de médecine douce.",
    imagePath: "images/alternative.jpeg",
  ),
];
