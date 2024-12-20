import 'package:flutter/material.dart';

class ReservationDetailsPage extends StatelessWidget {
  final Map<String, dynamic> data;

  ReservationDetailsPage({required this.data});

  @override
  Widget build(BuildContext context) {
    final String serviceName = data['serviceName'] ?? 'Service';
    final String userName = data['userName'] ?? 'Utilisateur';
    final String reservationDate = data['selectedDate'] ?? '';
    final String? restaurantName = data['restaurant'];
    final String? selectedMenu = data['selectedMenu'];
    final String? phoneNumber = data['phoneNumber'];
    final String? paymentMethod = data['paymentMethod'];
    final int? numberOfGuests = data['numberOfGuests'] is String
        ? int.tryParse(data['numberOfGuests'] ?? '')
        : data['numberOfGuests'];
    final String? reservationStatus =
        data['status']; // Status de la réservation

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de la réservation'),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: SingleChildScrollView(
        // Permet de défiler si le contenu est long
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Service
            _buildSectionTitle('Service'),
            Text(
              serviceName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            // Section Utilisateur
            _buildSectionTitle('Réservé par'),
            Text(userName, style: TextStyle(fontSize: 16)),

            // Section Date
            _buildSectionTitle('Date de réservation'),
            Text(reservationDate, style: TextStyle(fontSize: 16)),

            // Section Statut
            if (reservationStatus != null) _buildSectionTitle('Statut'),
            Text(reservationStatus!,
                style: const TextStyle(fontSize: 16, color: Colors.blue)),

            // Section spécifique aux restaurants
            if (serviceName == 'Restaurants') ...[
              _buildSectionTitle('Restaurant'),
              Text(restaurantName ?? 'Non spécifié',
                  style: TextStyle(fontSize: 16)),
              _buildSectionTitle('Menu choisi'),
              Text(selectedMenu ?? 'Aucun menu choisi',
                  style: TextStyle(fontSize: 16)),
              _buildSectionTitle('Nombre de places'),
              Text(numberOfGuests?.toString() ?? 'Non spécifié',
                  style: TextStyle(fontSize: 16)),
            ],

            // Section Téléphone
            if (phoneNumber != null) ...[
              _buildSectionTitle('Numéro de téléphone'),
              Text(phoneNumber, style: TextStyle(fontSize: 16)),
            ],

            // Section Méthode de paiement
            if (paymentMethod != null) ...[
              _buildSectionTitle('Méthode de paiement'),
              Text(paymentMethod, style: TextStyle(fontSize: 16)),
            ],

            // Boutons d'action
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Action de modification
                  },
                  child: Text('Modifier'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Action d'annulation
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Annuler'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget de titre de section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
      ),
    );
  }
}
