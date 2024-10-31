import 'package:flutter/material.dart';

class HotelPage extends StatelessWidget {
  // Liste des hôtels avec image, nom et description
  final List<Map<String, String>> hotels = [
    {
      'image': 'images/ONOMO.jpeg',
      'name': 'Hôtel ONOMO',
      'description':
          'Hôtel moderne situé à proximité de l\'aéroport avec des chambres confortables.'
    },
    {
      'image': 'images/atlantic.jpeg',
      'name': 'Atlantic Hôtel',
      'description':
          'Hôtel luxueux offrant une vue imprenable sur l\'océan Atlantique.'
    },
    {
      'image': 'images/noom.jpeg',
      'name': 'Noom',
      'description':
          'Hôtel branché avec un design contemporain et des installations de premier ordre.'
    },
    {
      'image': 'images/palm.jpeg',
      'name': 'Hôtel Palm Camayenne',
      'description':
          'Hôtel prestigieux avec une piscine et des services de spa.'
    },
    {
      'image': 'images/millenium.jpeg',
      'name': 'Millenium Suite',
      'description':
          'Charmant hôtel offrant une ambiance paisible et des jardins magnifiques.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hôtels'),
        backgroundColor: const Color.fromARGB(255, 101, 140, 212),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Retour à la page précédente
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: hotels.length,
          itemBuilder: (context, index) {
            return _buildHotelListItem(
              context,
              hotels[index]['image']!,
              hotels[index]['name']!,
              hotels[index]['description']!,
            );
          },
        ),
      ),
    );
  }

  // Widget pour construire chaque élément de la liste d'hôtels
  Widget _buildHotelListItem(
      BuildContext context, String imagePath, String name, String description) {
    return InkWell(
      onTap: () {
        // Naviguer vers la page de détails d'un hôtel
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HotelDetailsPage(hotelName: name),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Image à gauche
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  height: 100, // Ajuster la hauteur de l'image
                  width: 100, // Ajuster la largeur de l'image
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16), // Espace entre l'image et les détails
              // Détails de l'hôtel à droite
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Page de détails de l'hôtel
class HotelDetailsPage extends StatelessWidget {
  final String hotelName;

  const HotelDetailsPage({Key? key, required this.hotelName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotelName),
      ),
      body: Center(
        child: Text(
          'Détails de l\'hôtel $hotelName',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
