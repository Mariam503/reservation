import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reservation_service/model/reservationList.dart'; // Assurez-vous que Reservation est bien défini

class ReservationListPage extends StatefulWidget {
  final List<String> initialReservations;

  const ReservationListPage({Key? key, required this.initialReservations})
      : super(key: key);

  @override
  _ReservationListPageState createState() => _ReservationListPageState();
}

class _ReservationListPageState extends State<ReservationListPage> {
  late Future<List<Reservation>> _reservations;
  String? _filterService;

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
      body: Column(
        children: [
          _buildFilterDropdown(),
          Expanded(
            child: FutureBuilder<List<Reservation>>(
              future: _reservations,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erreur: ${snapshot.error}'));
                } else {
                  final reservations = snapshot.data ?? [];
                  if (reservations.isEmpty) {
                    return const Center(
                        child: Text('Aucune réservation trouvée.'));
                  }

                  return RefreshIndicator(
                    onRefresh: _refreshReservations,
                    child: ListView.builder(
                      itemCount: reservations.length,
                      itemBuilder: (context, index) {
                        final reservation = reservations[index];
                        return Dismissible(
                          key: Key(reservation.id),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            _deleteReservation(reservation);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Réservation supprimée avec succès")),
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: ListTile(
                              leading: Icon(
                                reservation.service == 'Concerts'
                                    ? Icons.music_note
                                    : Icons.bookmark,
                                color: reservation.service == 'Concerts'
                                    ? Colors.blue
                                    : Colors.green,
                              ),
                              title: Text(reservation.service),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Date: ${reservation.date}'),
                                  Text('Heure: ${reservation.time}'),
                                  if (reservation.service == 'Concerts')
                                    Row(
                                      children: [
                                        Icon(Icons.music_note,
                                            color: Colors.blue),
                                        SizedBox(width: 8),
                                        Text(
                                          'Type de billet: ${reservation.details}',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ],
                                    ),
                                  Text('Nom: ${reservation.name}'),
                                  Text('Téléphone: ${reservation.phone}'),
                                ],
                              ),
                              dense: true,
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (reservation.service != 'Concerts')
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () =>
                                          _confirmDeleteReservation(
                                              reservation),
                                    ),
                                  if (reservation.service == 'Concerts')
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.grey),
                                      onPressed: null,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<String>(
        value: _filterService,
        hint: const Text("Filtrer par service"),
        onChanged: (value) {
          setState(() {
            _filterService = value;
            _reservations =
                _getReservations(); // Rafraîchir les réservations avec le filtre appliqué
          });
        },
        items:
            ['Concerts', 'Restaurants', 'Hôtels', 'Autre'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Future<List<Reservation>> _getReservations() async {
    return await _getReservationsFromDatabase();
  }

  Future<List<Reservation>> _getReservationsFromDatabase() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('reservations').get();
      if (snapshot.docs.isEmpty) {
        return [];
      }

      final reservations = snapshot.docs.map((doc) {
        final data = doc.data();
        return Reservation(
          service: data['service'] ?? '',
          date: data['date'] ?? '',
          time: data['time'] ?? '',
          name: data['name'] ?? '',
          phone: data['phone'] ?? '',
          details: data['details'] ?? '',
          id: doc.id,
        );
      }).toList();

      reservations.sort((a, b) {
        int serviceComparison = a.service.compareTo(b.service);
        if (serviceComparison != 0) return serviceComparison;
        return a.date.compareTo(b.date);
      });

      // Filtrage des réservations si un filtre est appliqué
      if (_filterService != null && _filterService!.isNotEmpty) {
        return reservations
            .where((reservation) => reservation.service == _filterService)
            .toList();
      }

      return reservations;
    } catch (e) {
      print(
          'Erreur lors de la récupération des réservations depuis Firestore: $e');
      return [];
    }
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
              child:
                  const Text('Supprimer', style: TextStyle(color: Colors.red)),
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
    try {
      // Supprimer la réservation de Firestore
      await FirebaseFirestore.instance
          .collection('reservations')
          .doc(reservation.id)
          .delete();

      // Rafraîchir la liste des réservations après suppression
      _refreshReservations();
    } catch (e) {
      print('Erreur lors de la suppression de la réservation: $e');
    }
  }
}
