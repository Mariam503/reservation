import 'package:flutter/material.dart';
import 'package:reservation_service/model/concert.dart';
import 'package:reservation_service/pages/SousService/concert/concertDetail.dart';

class ConcertPage extends StatelessWidget {
  const ConcertPage({Key? key}) : super(key: key);

  // Méthode pour obtenir la liste des concerts
  List<Concert> getConcerts() {
    return [
      Concert(
        title: 'Fally Ipupa',
        image: 'images/fally_ipupa.jpeg',
        location: 'Conakry',
        date: '20/12/2024',
        description:
            'Concert de l\'artiste Fally Ipupa, un événement à ne pas manquer!',
        category: '',
      ),
      Concert(
        title: 'SMS Tueur',
        image: 'images/sms_tueur.jpeg',
        location: 'Conakry',
        date: '22/12/2024',
        description: 'SMS Tueur sur scène pour une soirée inoubliable.',
        category: '',
      ),
      Concert(
        title: 'Tiakola',
        image: 'images/tiakola.jpeg',
        location: 'Conakry',
        date: '25/12/2024',
        description: 'Tiakola, la sensation musicale du moment!',
        category: '',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final concerts = getConcerts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Concerts'),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: concerts.length,
        itemBuilder: (context, index) {
          final concert = concerts[index];
          return ConcertCard(concert: concert);
        },
      ),
    );
  }
}

class ConcertCard extends StatelessWidget {
  final Concert concert;

  const ConcertCard({Key? key, required this.concert}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Image de l'artiste
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                concert.image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16), // Espacement entre l'image et les textes
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    concert.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lieu : ${concert.location}\nDate : ${concert.date}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConcertDetailPage(concert: concert),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00796B),
              ),
              child: const Text(
                'Détails',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
