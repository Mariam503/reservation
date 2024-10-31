import 'package:flutter/material.dart';

import 'package:reservation_service/pages/detailsServices/reservationPage.dart'; // Importez la page de liste des réservations

class RestaurantDetailsPage extends StatelessWidget {
  final String restaurantName;
  final String restaurantImage;

  const RestaurantDetailsPage(
      {super.key, required this.restaurantName, required this.restaurantImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurantName),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image représentant le restaurant
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                image: DecorationImage(
                  image: AssetImage(restaurantImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurantName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00796B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Ce restaurant est connu pour sa cuisine délicieuse et son ambiance chaleureuse.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Icon(Icons.location_on, color: Color(0xFF00796B)),
                      SizedBox(width: 8),
                      Text(
                        '123 Rue du Bon Appétit, Conakry, Guinée',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Icon(Icons.access_time, color: Color(0xFF00796B)),
                      SizedBox(width: 8),
                      Text(
                        'Ouvert : 9h - 22h',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Spécialités :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00796B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• Plats végétariens'),
                      Text('• Cuisine locale'),
                      Text('• Vins et cocktails'),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Naviguer vers la page de réservation
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ReservationPage(restaurantName: restaurantName),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00796B),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Resever',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
