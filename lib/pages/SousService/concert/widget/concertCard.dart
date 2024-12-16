import 'package:flutter/material.dart';
import 'package:reservation_service/model/concert.dart';
import 'package:reservation_service/pages/SousService/concert/concertDetail.dart';

class ConcertCard extends StatelessWidget {
  final Concert concert;

  const ConcertCard({Key? key, required this.concert}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: LayoutBuilder(
          builder: (context, constraints) {
            double imageWidth =
                constraints.maxWidth * 0.3; // Ajuster la taille de l'image
            return Image.asset(
              concert.image,
              width: imageWidth,
              height: imageWidth,
              fit: BoxFit.cover,
            );
          },
        ),
        title: Text(concert.title),
        subtitle: Text('Lieu : ${concert.location}\nDate : ${concert.date}'),
        trailing: ElevatedButton(
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
          child: const Text('Détails'),
        ),
      ),
    );
  }
}
