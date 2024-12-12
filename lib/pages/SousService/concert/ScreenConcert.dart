import 'package:flutter/material.dart';

class ConcertPage extends StatelessWidget {
  const ConcertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Concerts'),
        backgroundColor: const Color(0xFF6A1B9A),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Action pour ouvrir le menu de filtres
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              // Action pour accéder aux favoris ou réservations
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Bannière visuelle
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('images/concert_banner.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 20),
          // Liste des concerts
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10, // Exemple : 10 concerts
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Image.asset(
                    'images/concert${index + 1}.jpg',
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                  title: Text('Concert ${index + 1}'),
                  subtitle: Text('Lieu : Abidjan\nDate : 20/12/2024'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConcertDetailPage(
                            concertTitle: 'Concert ${index + 1}',
                            location: 'Abidjan',
                            date: '20/12/2024',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6A1B9A),
                    ),
                    child: const Text('Détails'),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ConcertDetailPage extends StatelessWidget {
  final String concertTitle;
  final String location;
  final String date;

  const ConcertDetailPage({
    Key? key,
    required this.concertTitle,
    required this.location,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(concertTitle),
        backgroundColor: const Color(0xFF6A1B9A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'images/concert_detail.jpg',
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              concertTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Lieu : $location\nDate : $date',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Description : Ce concert met en avant les meilleurs artistes de la scène musicale actuelle. Venez vivre une expérience inoubliable avec une ambiance exceptionnelle.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Ajouter une action pour la réservation
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A1B9A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Réserver'),
            ),
          ],
        ),
      ),
    );
  }
}
