import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationListPage extends StatefulWidget {
  @override
  _ReservationListPageState createState() => _ReservationListPageState();
}

class _ReservationListPageState extends State<ReservationListPage> {
  late Stream<QuerySnapshot> _reservationsStream;

  @override
  void initState() {
    super.initState();
    // Récupération en temps réel des réservations depuis Firestore
    _reservationsStream =
        FirebaseFirestore.instance.collection('reservations').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des réservations"),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _reservationsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Aucune réservation trouvée.'));
          }

          final reservations = snapshot.data!.docs;

          return ListView.builder(
            itemCount: reservations.length,
            itemBuilder: (context, index) {
              final data = reservations[index].data() as Map<String, dynamic>;
              return _buildReservationCard(data, reservations[index].id);
            },
          );
        },
      ),
    );
  }

  Widget _buildReservationCard(Map<String, dynamic> data, String documentId) {
    final String serviceName = data['serviceName'] ?? 'Service';
    final String userName = data['userName'] ?? 'Utilisateur';
    final String reservationDate = data['reservationDate'] ?? '';
    final String? ticketType =
        data['ticketType']; // Type de ticket pour les concerts
    final String? phoneNumber = data['phoneNumber'];
    final String? paymentMethod = data['paymentMethod'];
    final int? numberOfGuests = data['numberOfGuests'] is String
        ? int.tryParse(data['numberOfGuests'] ?? '')
        : data['numberOfGuests'];
    final String? reservationStatus =
        data['status']; // Statut de la réservation

    // Ajouter les informations spécifiques au salon
    final String salonName = data['salonName'] ?? 'Salon';
    final String salonDescription =
        data['salonDescription'] ?? 'Description non disponible';

    // Définir un style de texte réutilisable
    final TextStyle subTextStyle = TextStyle(fontSize: 14, color: Colors.grey);

    // Map pour associer les services à leurs icônes
    final serviceIcons = {
      'Concerts': Icons.music_note,
      'Restaurants': Icons.restaurant,
      'Salons': Icons.business_center,
    };

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(
          serviceIcons[serviceName] ?? Icons.event,
          color: Colors.teal,
        ),
        title: Text(
          serviceName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Réservé par: $userName', style: subTextStyle),
            Text('Date de réservation: $reservationDate', style: subTextStyle),
            if (reservationStatus != null)
              Text('Statut: $reservationStatus',
                  style: TextStyle(fontSize: 14, color: Colors.blue)),
            if (serviceName == 'Concerts') ...[
              Text('Type de ticket: $ticketType', style: subTextStyle),
            ],
            if (serviceName == 'Restaurants') ...[
              Text('Nombre de places: $numberOfGuests', style: subTextStyle),
            ],
            if (serviceName == 'Salons') ...[
              Text('Salon: $salonName', style: subTextStyle),
              Text('Description: $salonDescription', style: subTextStyle),
            ],
            if (phoneNumber != null)
              Text('Numéro de téléphone: $phoneNumber', style: subTextStyle),
            if (paymentMethod != null)
              Text('Méthode de paiement: $paymentMethod', style: subTextStyle),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.cancel, color: Colors.red),
          onPressed: () {
            _showCancelDialog(context, documentId);
          },
          tooltip: 'Annuler la réservation',
        ),
      ),
    );
  }

  // Méthode pour afficher un dialogue de confirmation d'annulation
  void _showCancelDialog(BuildContext context, String documentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Annuler la réservation'),
          content: Text('Êtes-vous sûr de vouloir annuler cette réservation ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
              child: Text('Non'),
            ),
            TextButton(
              onPressed: () {
                _cancelReservation(context, documentId);
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
              child: Text('Oui'),
            ),
          ],
        );
      },
    );
  }

  // Méthode pour annuler la réservation
  void _cancelReservation(BuildContext context, String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('reservations')
          .doc(documentId)
          .delete();
      // Mise à jour du stream pour refléter l'annulation
      setState(() {
        _reservationsStream =
            FirebaseFirestore.instance.collection('reservations').snapshots();
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Réservation annulée')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de l\'annulation: $e')));
    }
  }
}
