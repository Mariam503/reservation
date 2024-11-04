import 'package:flutter/material.dart';
import 'package:reservation_service/model/reservation.dart';
import 'package:reservation_service/pages/detailsServices/editReservation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ReservationListPage extends StatefulWidget {
  final List<String> initialReservations;

  const ReservationListPage({Key? key, required this.initialReservations})
      : super(key: key);

  @override
  _ReservationListPageState createState() => _ReservationListPageState();
}

class _ReservationListPageState extends State<ReservationListPage> {
  late Future<List<Reservation>> _reservations;

  @override
  void initState() {
    super.initState();
    _reservations = _getReservations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des réservations"),
        backgroundColor: Color(0xFF00796B),
      ),
      body: FutureBuilder<List<Reservation>>(
        future: _reservations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else {
            final reservations = snapshot.data ?? [];
            if (reservations.isEmpty) {
              return const Center(child: Text('Aucune réservation trouvée.'));
            }

            return ListView.builder(
              itemCount: reservations.length,
              itemBuilder: (context, index) {
                final reservation = reservations[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(reservation.service),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date: ${reservation.date}'),
                        Text('Heure: ${reservation.time}'),
                        Text('Détails: ${reservation.details}'),
                        Text('Nom: ${reservation.name}'),
                        Text('Téléphone: ${reservation.phone}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.edit, color: Color(0xFF00796B)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditReservationPage(
                                    reservation: reservation),
                              ),
                            ).then((updated) async {
                              if (updated == true) {
                                _refreshReservations();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Réservation modifiée avec succès")),
                                );
                              }
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () =>
                              _confirmDeleteReservation(reservation),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Reservation>> _getReservations() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> reservations = widget.initialReservations.isNotEmpty
        ? widget.initialReservations
        : (prefs.getStringList('reservations') ?? []);

    return reservations.map((reservation) {
      return Reservation.fromJson(json.decode(reservation));
    }).toList();
  }

  Future<void> _refreshReservations() async {
    List<Reservation> updatedReservations = await _getReservations();
    setState(() {
      _reservations = Future.value(updatedReservations);
    });
  }

  Future<void> _confirmDeleteReservation(Reservation reservation) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alerte'),
          content:
              const Text('Voulez-vous vraiment supprimer cette réservation ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Supprimer',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      await _deleteReservation(reservation);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Réservation supprimée avec succès")),
      );
    }
  }

  Future<void> _deleteReservation(Reservation reservation) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> reservations = prefs.getStringList('reservations') ?? [];
    reservations.remove(json.encode(reservation.toJson()));
    await prefs.setStringList('reservations', reservations);
    _refreshReservations();
  }
}
