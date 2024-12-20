import 'package:flutter/material.dart';
import 'package:reservation_service/pages/SousService/nettoyage/cleaningResservation.dart';
import 'package:url_launcher/url_launcher.dart';

class CleaningServiceDetailsPage extends StatelessWidget {
  final String serviceName;

  CleaningServiceDetailsPage({required this.serviceName});

  @override
  Widget build(BuildContext context) {
    // Exemple de tarif dynamique
    final serviceDetails = _getServiceDetails(serviceName);

    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du service de nettoyage'),
        backgroundColor: const Color(0xFF00796B),
        elevation: 6,
      ),
      body: Stack(
        children: [
          // Contenu principal
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image du service
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        serviceDetails['image']!,
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Titre et description du service
                  Text(
                    'Service: $serviceName',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00796B)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Description du service:',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                  Text(
                    serviceDetails['description']!,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),

                  SizedBox(height: 20),

                  // Tarif
                  Text(
                    'Tarif: ${serviceDetails['price']} / Heure',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00796B)),
                  ),
                  SizedBox(height: 20),

                  // Adresse de l'entreprise
                  Text(
                    'Adresse :',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '123 Rue de l\'Entreprise, Conakry, Guinée',
                    style: TextStyle(fontSize: 16),
                  ),

                  SizedBox(height: 20),

                  // Contact
                  Text(
                    'Contact :',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Color(0xFF00796B)),
                      SizedBox(width: 8),
                      Text('+224 123 456 789', style: TextStyle(fontSize: 16)),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Horaires de disponibilité
                  Text(
                    'Horaires :',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Lundi - Samedi: 08h00 - 18h00',
                    style: TextStyle(fontSize: 16),
                  ),

                  SizedBox(height: 20),

                  // Avis des utilisateurs
                  Text(
                    'Avis :',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(Icons.star,
                          color: index < 4 ? Colors.orange : Colors.grey);
                    }),
                  ),
                  Text(
                    '4.5/5 basé sur 20 avis',
                    style: TextStyle(fontSize: 16),
                  ),

                  SizedBox(height: 20),

                  // Services supplémentaires
                  Text(
                    'Services supplémentaires :',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '- Nettoyage de tapis',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '- Produits écologiques disponibles',
                    style: TextStyle(fontSize: 16),
                  ),

                  SizedBox(height: 20),

                  // Formulaire d'instructions spéciales
                  Text(
                    'Instructions spéciales :',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Écrivez vos instructions spéciales ici...',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Carte Google Maps (lien)
                  Text(
                    'Voir sur la carte :',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () {
                      // Remplacer l'URL par le lien Google Maps de l'adresse
                      launch(
                          'https://www.google.com/maps?q=123 Rue de l\'Entreprise, Conakry');
                    },
                    child: Text(
                      'Voir sur Google Maps',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),

                  SizedBox(height: 30),

                  // Politique d'annulation
                  Text(
                    'Politique d\'annulation :',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Annulation gratuite jusqu\'à 24 heures avant la réservation.',
                    style: TextStyle(fontSize: 16),
                  ),

                  SizedBox(height: 20),

                  // Galerie de photos (images qui prennent toute la largeur)
                  Text(
                    'Nos réalisations :',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Image.asset('images/domstique.jpeg',
                            height: 150, fit: BoxFit.cover),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Image.asset('images/bureautique.jpeg',
                            height: 150, fit: BoxFit.cover),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Image.asset('images/renov.jpeg',
                            height: 150, fit: BoxFit.cover),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              // Centrer le bouton horizontalement
              child: ElevatedButton(
                onPressed: () {
                  // Naviguer vers la page de réservation
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CleaningServiceReservationPage(
                            serviceName: serviceName)),
                  );
                },
                child: Text(
                  'Réserver',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00796B),
                  padding: EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0), // Réduit la largeur
                  elevation: 5,
                  textStyle:
                      TextStyle(fontSize: 16), // Réduit la taille du texte
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Map<String, String> _getServiceDetails(String serviceName) {
    // Exemple de service avec des informations dynamiques
    switch (serviceName) {
      case 'Nettoyage à domicile':
        return {
          'description':
              'Un service de nettoyage professionnel pour votre domicile.',
          'price': '200.000 GNF',
          'image': 'images/domicile.jpeg',
        };
      case 'Nettoyage de bureau':
        return {
          'description':
              'Service de nettoyage pour bureaux et espaces professionnels.',
          'price': '350.000 GNF',
          'image': 'images/bureau.jpeg',
        };
      default:
        return {
          'description': 'Service de nettoyage spécialisé.',
          'price': '700.000 GNF',
          'image': 'images/renovation.jpeg',
        };
    }
  }
}
