class HealthSubService {
  final String name; // Nom du sous-service
  final String description; // Description du service
  final String imagePath; // Chemin de l'image du service
  final String contactNumber; // Numéro de contact du service

  HealthSubService({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.contactNumber,
  });
}

// Liste simulée des sous-services pour la démonstration
List<HealthSubService> healthSubServices = [
  HealthSubService(
    name: "Urgences",
    description: "Appeler et signaler une urgence rapidement.",
    imagePath: "images/urgences.jpeg",
    contactNumber: "112", // Exemple de numéro d'urgence
  ),
  HealthSubService(
    name: "Consultation médicale",
    description: "Prenez rendez-vous avec un médecin.",
    imagePath: "images/consultation.jpeg",
    contactNumber: "1234567890", // Exemple de numéro de consultation
  ),
  HealthSubService(
    name: "Médecine Alternative",
    description: "Réservez des séances de médecine douce.",
    imagePath: "images/alternative.jpeg", // Correction du chemin d'image
    contactNumber: "444333222", // Correction du champ contactNumber
  ),
  HealthSubService(
    name: "Pharmacie",
    description: "Réservez des séances de médecine douce.",
    imagePath: "images/pharmacie.jpeg", // Correction du chemin d'image
    contactNumber: "444333222", // Correction du champ contactNumber
  ),
];
