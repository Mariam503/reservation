import 'package:flutter/material.dart';
import 'package:reservation_service/pages/SousService/salonCoiffures/salonCard.dart';

import 'package:reservation_service/pages/SousService/salonCoiffures/screenSalonDetails.dart';

class SalonsCoiffurePage extends StatelessWidget {
  final List<Map<String, String>> salons = [
    {
      'name': 'Salon Élite',
      'description': 'Un service professionnel pour vos cheveux.',
      'image': 'images/casaonova.jpeg',
    },
    {
      'name': 'Chic & Choc',
      'description': 'Des coiffures élégantes et modernes.',
      'image': 'images/femme.jpeg',
    },
    {
      'name': 'Beauté Royale',
      'description': 'Un service luxueux et des produits de qualité.',
      'image': 'images/casa.jpeg',
    },
    {
      'name': 'Style Urbain',
      'description': 'Le salon tendance en plein cœur de la ville.',
      'image': 'images/cuting.jpeg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salons de Coiffure'),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Expanded(
          // Ajoutez un Expanded ici
          child: GridView.builder(
            itemCount: salons.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: 3 / 4,
            ),
            itemBuilder: (context, index) {
              final salon = salons[index];
              return SalonCard(
                name: salon['name']!,
                description: salon['description']!,
                image: salon['image']!,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SalonDetailsPage(
                        salonName: salon['name']!,
                        salonDescription: salon['description']!,
                        salonImage: salon['image']!,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
