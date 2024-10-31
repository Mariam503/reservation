import 'package:flutter/material.dart';

class ReservationListPage extends StatelessWidget {
  final List<Map<String, String>> reservations;

  const ReservationListPage({Key? key, required this.reservations})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des réservations'),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: reservations.isNotEmpty
            ? ListView.builder(
                itemCount: reservations.length,
                itemBuilder: (context, index) {
                  final reservation = reservations[index];
                  return _buildReservationCard(reservation);
                },
              )
            : const Center(
                child: Text(
                  'Aucune réservation disponible.',
                  style: TextStyle(fontSize: 18),
                ),
              ),
      ),
    );
  }

  // Fonction pour afficher chaque réservation sous forme de carte
  Widget _buildReservationCard(Map<String, String> reservation) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reservation['service']!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildDetailRow('Date', reservation['date']!),
            const SizedBox(height: 5),
            _buildDetailRow('Heure', reservation['time']!),
            const SizedBox(height: 5),
            _buildDetailRow('Détails', reservation['details']!),
          ],
        ),
      ),
    );
  }

  // Fonction pour formater l'affichage des détails
  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(value),
      ],
    );
  }
}
