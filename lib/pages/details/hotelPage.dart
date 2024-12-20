import 'package:flutter/material.dart';
import 'package:reservation_service/pages/details/hotel/screenhotelDetail.dart';

// Liste des hôtels
List<Map<String, String>> hotels = [
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
    'description': 'Hôtel prestigieux avec une piscine et des services de spa.'
  },
  {
    'image': 'images/millenium.jpeg',
    'name': 'Millenium Suite',
    'description':
        'Charmant hôtel offrant une ambiance paisible et des jardins magnifiques.'
  },
];

class HotelListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hôtels'),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: ListView.separated(
        itemCount: hotels.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final hotel = hotels[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              leading: Image.asset(
                hotel['image']!,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              title: Text(
                hotel['name']!,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(hotel['description']!),
              onTap: () {
                // Naviguer vers la page de détails de l'hôtel
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HotelDetailsPage(
                      hotelName: hotel['name']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
