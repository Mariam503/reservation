import 'package:flutter/material.dart';
import 'package:reservation_service/model/modelPharmacy.dart';
import 'package:reservation_service/pages/detailsServices/sousSante/pharmacy/pharmacyList.dart';
// Ajout de l'import pour PharmacyDetailPage
import 'package:url_launcher/url_launcher.dart';

class PharmacyScreen extends StatefulWidget {
  @override
  _PharmacyScreenState createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends State<PharmacyScreen> {
  final List<Pharmacie> pharmacies = [
    Pharmacie(
      id: "1",
      nom: "Diaguissa",
      adresse: "Adresse A",
      telephone: "123456789",
      imageUrl: "images/cosa.jpeg",
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
        Horaire(
            jour: "Samedi", heureOuverture: "9h00", heureFermeture: "15h00"),
        Horaire(jour: "Dimanche", heureOuverture: "Fermé", heureFermeture: ""),
      ],
      estDeGarde: true,
      rating: 4.5,
      nombreAvis: 150,
      medicaments: [
        Medicament(
          nom: "Aspirine",
          description: "Médicament contre la douleur",
          imageUrl: "images/aspirine.jpeg",
          prix: 300.00,
        ),
        Medicament(
          nom: "Paracétamol",
          description: "Antalgique et antipyrétique",
          imageUrl: "images/paracetmol.jpeg",
          prix: 50.00,
        ),
      ],
    ),
    Pharmacie(
      id: "2",
      nom: "Pharmacie de Cosa",
      adresse: "Adresse B",
      telephone: "987654321",
      imageUrl: "images/diaguissa.jpeg",
      latitude: 45.7640,
      longitude: 4.8357,
      services: [
        ServicePharmacie.Orthopedie,
        ServicePharmacie.Beaute,
        ServicePharmacie.ConseilMedical
      ],
      horaires: [
        Horaire(
            jour: "Lundi-Vendredi",
            heureOuverture: "7h30",
            heureFermeture: "19h30"),
        Horaire(
            jour: "Samedi", heureOuverture: "8h00", heureFermeture: "16h00"),
        Horaire(
            jour: "Dimanche", heureOuverture: "8h00", heureFermeture: "12h00"),
      ],
      estDeGarde: false,
      rating: 4.0,
      nombreAvis: 90,
      medicaments: [
        Medicament(
          nom: "Ibuprofène",
          description: "Anti-inflammatoire non stéroïdien",
          imageUrl: "assets/images/ibuprofen.jpg",
          prix: 20.00,
        ),
        Medicament(
          nom: "Amoxicilline",
          description: "Antibiotique",
          imageUrl: "assets/images/amoxicilline.jpg",
          prix: 10.00,
        ),
      ],
    ),
    Pharmacie(
      id: "3",
      nom: "Hadja",
      adresse: "Adresse C",
      telephone: "111222333",
      imageUrl: "images/pharmacie.jpeg",
      latitude: 34.0522,
      longitude: -118.2437,
      services: [ServicePharmacie.TestCOVID, ServicePharmacie.Vaccination],
      horaires: [
        Horaire(
            jour: "Lundi-Vendredi",
            heureOuverture: "9h00",
            heureFermeture: "18h00"),
        Horaire(
            jour: "Samedi", heureOuverture: "10h00", heureFermeture: "14h00"),
        Horaire(jour: "Dimanche", heureOuverture: "Fermé", heureFermeture: ""),
      ],
      estDeGarde: true,
      rating: 3.8,
      nombreAvis: 70,
      medicaments: [
        Medicament(
          nom: "Vitamine C",
          description:
              "Complément alimentaire pour renforcer le système immunitaire",
          imageUrl: "assets/images/vitamine_c.jpg",
          prix: 15.00,
        ),
        Medicament(
          nom: "Oméprazole",
          description: "Traitement des ulcères et des reflux gastriques",
          imageUrl: "assets/images/omeprazole.jpg",
          prix: 25.00,
        ),
      ],
    ),
    Pharmacie(
      id: "4",
      nom: "Bokoum Pharmacie ",
      adresse: "Adresse D",
      telephone: "444555666",
      imageUrl: "images/bambeto.jepg",
      latitude: 51.5074,
      longitude: -0.1278,
      services: [ServicePharmacie.Beaute, ServicePharmacie.Orthopedie],
      horaires: [
        Horaire(
            jour: "Lundi-Dimanche",
            heureOuverture: "8h00",
            heureFermeture: "20h00"),
      ],
      estDeGarde: false,
      rating: 4.3,
      nombreAvis: 120,
      medicaments: [
        Medicament(
          nom: "Doliprane",
          description: "Antalgique et antipyrétique",
          imageUrl: "assets/images/doliprane.jpg",
          prix: 45.00,
        ),
        Medicament(
          nom: "Cétirizine",
          description: "Antihistaminique pour le traitement des allergies",
          imageUrl: "assets/images/cetirizine.jpg",
          prix: 30.00,
        ),
      ],
    ),
  ];

  String query = "";

  List<Pharmacie> _getFiltredPharmacies() {
    return pharmacies
        .where((pharmacie) =>
            pharmacie.nom.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<void> _appellerPharmacie(String numero) async {
    final Uri launchUri = Uri(scheme: 'tel', path: numero);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $numero';
    }
  }

  Future<void> _ouvrirNavigation(Pharmacie pharmacie) async {
    final Uri googleMapsUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${pharmacie.latitude},${pharmacie.longitude}');
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      throw 'Could not open maps for ${pharmacie.nom}';
    }
  }

  void _ouvrirPageDetail(BuildContext context, Pharmacie pharmacie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PharmacieDetailsPage(
          pharmacie: pharmacie,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtredPharmacies = _getFiltredPharmacies();

    return Scaffold(
      appBar: AppBar(
        title: Text("Pharmacies"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => setState(() => query = value),
              decoration: InputDecoration(
                hintText: "Rechercher une pharmacie",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          if (filtredPharmacies.isEmpty)
            Center(child: Text("Aucune pharmacie trouvée")),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: filtredPharmacies.length,
              itemBuilder: (context, index) {
                final pharmacie = filtredPharmacies[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          pharmacie.imageUrl,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        right: 10,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.phone, color: Colors.green),
                                  onPressed: () =>
                                      _appellerPharmacie(pharmacie.telephone),
                                ),
                                IconButton(
                                  icon: Icon(Icons.chat, color: Colors.blue),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Chat avec ${pharmacie.nom}")),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon:
                                      Icon(Icons.map_sharp, color: Colors.red),
                                  onPressed: () => _ouvrirNavigation(pharmacie),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () =>
                                  _ouvrirPageDetail(context, pharmacie),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              child: Text("Voir détails"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
