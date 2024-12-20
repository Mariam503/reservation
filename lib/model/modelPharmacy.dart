enum ServicePharmacie {
  Vaccination,
  TestCOVID,
  ConseilMedical,
  Orthopedie,
  Beaute
}

class Horaire {
  final String jour;
  final String heureOuverture;
  final String heureFermeture;

  Horaire({
    required this.jour,
    required this.heureOuverture,
    required this.heureFermeture,
  });

  Map<String, dynamic> toJson() => {
        'jour': jour,
        'heureOuverture': heureOuverture,
        'heureFermeture': heureFermeture,
      };

  static Horaire fromJson(Map<String, dynamic> json) => Horaire(
        jour: json['jour'],
        heureOuverture: json['heureOuverture'],
        heureFermeture: json['heureFermeture'],
      );
}

class Medicament {
  final String nom;
  final String description;
  final String imageUrl;
  final double prix;

  Medicament({
    required this.nom,
    required this.description,
    required this.imageUrl,
    required this.prix,
  });

  Map<String, dynamic> toJson() => {
        'nom': nom,
        'description': description,
        'imageUrl': imageUrl,
        'prix': prix,
      };

  static Medicament fromJson(Map<String, dynamic> json) => Medicament(
        nom: json['nom'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        prix: json['prix'],
      );
}

class Pharmacie {
  final String id;
  final String nom;
  final String adresse;
  final String telephone;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final List<ServicePharmacie> services; // Enum pour plus de robustesse
  final List<Horaire> horaires; // Liste d'objets horaires
  final bool estDeGarde; // Renommé pour plus de clarté
  final double rating;
  final int nombreAvis;
  final List<Medicament> medicaments;

  Pharmacie({
    required this.id,
    required this.nom,
    required this.adresse,
    required this.telephone,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    this.services = const [],
    this.horaires = const [],
    this.estDeGarde = false,
    this.rating = 0.0,
    this.nombreAvis = 0,
    required this.medicaments,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nom': nom,
        'adresse': adresse,
        'telephone': telephone,
        'imageUrl': imageUrl,
        'latitude': latitude,
        'longitude': longitude,
        'services': services
            .map((service) => service.toString().split('.').last)
            .toList(),
        'horaires': horaires.map((horaire) => horaire.toJson()).toList(),
        'estDeGarde': estDeGarde,
        'rating': rating,
        'nombreAvis': nombreAvis,
        'medicaments': medicaments.map((med) => med.toJson()).toList(),
      };

  static Pharmacie fromJson(Map<String, dynamic> json) => Pharmacie(
        id: json['id'],
        nom: json['nom'],
        adresse: json['adresse'],
        telephone: json['telephone'],
        imageUrl: json['imageUrl'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        services: (json['services'] as List)
            .map((service) => ServicePharmacie.values
                .firstWhere((e) => e.toString().split('.').last == service))
            .toList(),
        horaires: (json['horaires'] as List)
            .map((horaire) => Horaire.fromJson(horaire))
            .toList(),
        estDeGarde: json['estDeGarde'],
        rating: json['rating'],
        nombreAvis: json['nombreAvis'],
        medicaments: (json['medicaments'] as List)
            .map((med) => Medicament.fromJson(med))
            .toList(),
      );
}

// Exemple de données pour les pharmacies
final List<Pharmacie> pharmacies = [
  Pharmacie(
    id: "1",
    nom: "Pharmacie A",
    adresse: "Adresse A",
    telephone: "123456789",
    imageUrl: "assets/images/pharmacie_a.jpg",
    latitude: 48.8566,
    longitude: 2.3522,
    services: [
      ServicePharmacie.Vaccination,
      ServicePharmacie.TestCOVID,
      ServicePharmacie.ConseilMedical
    ],
    horaires: [
      Horaire(
          jour: "Lundi-Vendredi",
          heureOuverture: "8h00",
          heureFermeture: "20h00"),
      Horaire(jour: "Samedi", heureOuverture: "9h00", heureFermeture: "15h00"),
      Horaire(jour: "Dimanche", heureOuverture: "Fermé", heureFermeture: ""),
    ],
    estDeGarde: true,
    rating: 4.5,
    nombreAvis: 150,
    medicaments: [
      Medicament(
        nom: "Aspirine",
        description: "Médicament contre la douleur",
        imageUrl: "assets/images/aspirine.jpg",
        prix: 300.00,
      ),
      Medicament(
        nom: "Paracétamol",
        description: "Antalgique et antipyrétique",
        imageUrl: "assets/images/paracetamol.jpg",
        prix: 50.00,
      ),
    ],
  ),
];
