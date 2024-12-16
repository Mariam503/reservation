import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addReservation({
  required String serviceName,
  required String userName,
  required DateTime reservationDate,
  required int numberOfGuests,
  required String ticketType,
}) async {
  try {
    // Référence à la collection "reservations"
    final CollectionReference reservations =
        FirebaseFirestore.instance.collection('reservations');

    // Ajout des données dans la collection
    await reservations.add({
      'serviceName': serviceName,
      'userName': userName,
      'reservationDate': reservationDate.toIso8601String(),
      'numberOfGuests': numberOfGuests,
      'ticketType': ticketType,
    });
    print("Réservation ajoutée avec succès !");
  } catch (e) {
    print("Erreur lors de l'ajout de la réservation : $e");
    throw e; // Propager l'erreur pour la gérer ailleurs
  }
}
