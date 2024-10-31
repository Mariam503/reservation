import 'package:flutter/material.dart';
import 'package:reservation_service/pages/detailsServices/restaurantDetail.dart';
// Importer la page de détails du restaurant

class RestaurantPage extends StatelessWidget {
  // Liste des restaurants avec image, nom et description
  final List<Map<String, String>> restaurants = [
    {
      'image': 'images/barista.jpg',
      'name': 'Barista',
      'description':
          'Cuisine raffinée avec des plats traditionnels et modernes.'
    },
    {
      'image': 'images/cherry.jpg',
      'name': 'Cherry & Restaurant caffé',
      'description':
          'Bistro chaleureux offrant une ambiance décontractée et des plats faits maison.'
    },
    {
      'image': 'images/nomade.jpg',
      'name': 'La nomade',
      'description':
          'Authentique pizzeria avec une large sélection de pizzas cuites au feu de bois.'
    },
    {
      'image': 'images/fete_pizza.jpg',
      'name': 'Fête à pizza',
      'description':
          'Café moderne avec une belle terrasse et des cafés artisanaux.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'),
        backgroundColor: const Color(0xFF00796B),
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
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            return _buildRestaurantListItem(
              context,
              restaurants[index]['image']!,
              restaurants[index]['name']!,
              restaurants[index]['description']!,
            );
          },
        ),
      ),
    );
  }

  // Widget pour construire chaque élément de la liste de restaurants
  Widget _buildRestaurantListItem(
      BuildContext context, String imagePath, String name, String description) {
    return InkWell(
      onTap: () {
        // Naviguer vers la page de détails d'un restaurant
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDetailsPage(
              restaurantName: name,
              restaurantImage: '',
            ),
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
              // Détails du restaurant à droite
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
