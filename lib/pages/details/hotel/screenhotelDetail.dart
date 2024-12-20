import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

List<Map<String, String>> hotels = [
  {
    'image': 'images/ONOMO.jpeg',
    'name': 'Hôtel ONOMO',
    'description':
        'Hôtel moderne situé à proximité de l\'aéroport avec des chambres confortables.',
    'location': 'Conakry, Guinée',
  },
  {
    'image': 'images/atlantic.jpeg',
    'name': 'Atlantic Hôtel',
    'description':
        'Hôtel luxueux offrant une vue imprenable sur l\'océan Atlantique.',
    'location': 'Banjul, Gambie',
  },
  {
    'image': 'images/noom.jpeg',
    'name': 'Noom',
    'description':
        'Hôtel branché avec un design contemporain et des installations de premier ordre.',
    'location': 'Accra, Ghana',
  },
  {
    'image': 'images/palm.jpeg',
    'name': 'Hôtel Palm Camayenne',
    'description': 'Hôtel prestigieux avec une piscine et des services de spa.',
    'location': 'Conakry, Guinée',
  },
  {
    'image': 'images/millenium.jpeg',
    'name': 'Millenium Suite',
    'description':
        'Charmant hôtel offrant une ambiance paisible et des jardins magnifiques.',
    'location': 'Dakar, Sénégal',
  },
];

class HotelDetailsPage extends StatelessWidget {
  final String hotelName;

  const HotelDetailsPage({Key? key, required this.hotelName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hotelData = hotels.firstWhere(
      (hotel) => hotel['name'] == hotelName,
      orElse: () => {
        'name': 'Hôtel introuvable',
        'image': 'images/default.jpg',
        'description': 'Aucune information disponible.',
        'location': 'Non spécifiée',
      },
    );

    final String currentHotelName = hotelData['name'] ?? 'Nom de l\'hôtel';
    final String hotelImage = hotelData['image'] ?? 'images/default.jpg';
    final String hotelDescription =
        hotelData['description'] ?? 'Aucune description disponible.';
    final String hotelLocation =
        hotelData['location'] ?? 'Adresse non disponible';

    return Scaffold(
      appBar: AppBar(
        title: Text(currentHotelName),
        backgroundColor: const Color(0xFF00796B),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              Share.share('Check out this hotel: $currentHotelName');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    hotelImage,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  currentHotelName,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  hotelDescription,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Color(0xFF00796B)),
                    const SizedBox(width: 8),
                    Text(
                      hotelLocation,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Services disponibles : Wi-Fi, Piscine, Spa, Salle de réunion',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < 4 ? Icons.star : Icons.star_border,
                      color: Colors.yellow[700],
                    );
                  }),
                ),
                const SizedBox(height: 16),
                // Utilisation d'Align pour le bouton
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      // Action de réservation ou autre
                    },
                    child: const Text(
                      'Réserver une chambre',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00796B),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Avis des clients',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Icon(Icons.account_circle, size: 30),
                    SizedBox(width: 8),
                    Text('kokouma', style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Super hôtel, excellent service et très propre. Je reviendrai !',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
