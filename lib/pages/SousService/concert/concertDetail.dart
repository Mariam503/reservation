import 'package:flutter/material.dart';
import 'package:reservation_service/model/concert.dart';
import 'package:reservation_service/pages/SousService/concert/reservationConcert.dart';

class ConcertDetailPage extends StatelessWidget {
  final Concert concert;

  const ConcertDetailPage({Key? key, required this.concert}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Liste des types de billets et leurs prix
    final ticketPrices = [
      {'type': 'VVIP', 'price': 500000},
      {'type': 'VIP', 'price': 300000},
      {'type': 'Parterre', 'price': 150000},
      {'type': 'Standard', 'price': 80000},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(concert.title),
        backgroundColor: const Color(0xFF00796B),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Ajouter une fonctionnalité de partage ici
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image de couverture
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  concert.image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              // Titre
              Text(
                concert.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00796B),
                ),
              ),

              const SizedBox(height: 10),

              // Détails principaux
              Text(
                'Lieu : ${concert.location}\nDate : ${concert.date}',
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 20),

              // Description
              Text(
                'Description :\n${concert.description}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Liste des prix des billets
              const Text(
                'Prix des billets :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: ticketPrices.map((ticket) {
                  return TicketPriceRow(
                    type: ticket['type'] as String,
                    price: ticket['price'] as int,
                  );
                }).toList(),
              ),

              const SizedBox(height: 30),

              // Bouton de réservation
              ElevatedButton(
                onPressed: () {
                  handleReservation(context, concert,
                      'Standard'); // Réservation avec un type de billet par défaut
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00796B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Center(
                  child: Text(
                    'Réserver',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Bouton Favoris
              OutlinedButton.icon(
                onPressed: () {
                  // Ajouter une logique pour sauvegarder l'événement comme favori
                },
                icon:
                    const Icon(Icons.favorite_border, color: Color(0xFF00796B)),
                label: const Text(
                  'Ajouter aux favoris',
                  style: TextStyle(color: Color(0xFF00796B)),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF00796B)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleReservation(
      BuildContext context, Concert concert, String ticketType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReservationPage(
          concert: concert, // Passer l'objet concert entier
          ticketTypesWithPrices: const {
            'VVIP': 500000,
            'VIP': 300000,
            'Parterre': 150000,
            'Standard': 80000,
          },
          ticketType: ticketType,
        ),
      ),
    );
  }
}

// Widget pour afficher un type de billet avec son prix
class TicketPriceRow extends StatelessWidget {
  final String type;
  final int price;

  const TicketPriceRow({Key? key, required this.type, required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            type,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${price.toString()} GNF',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
