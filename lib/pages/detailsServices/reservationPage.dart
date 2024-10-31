import 'package:flutter/material.dart';
import 'package:reservation_service/pages/details/reservation.dart'; // Assurez-vous que l'importation est correcte

class ReservationPage extends StatefulWidget {
  final String restaurantName;

  const ReservationPage({super.key, required this.restaurantName});

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  String name = '';
  String phone = '';
  String? selectedDate;
  String? selectedTime;
  int numberOfPeople = 2; // Par défaut, table pour 2 personnes

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Clé pour le formulaire
  bool reservationConfirmed = false; // État de la réservation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Réserver - ${widget.restaurantName}"),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Formulaire avec clé
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Choisissez une date et une heure",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00796B)),
                ),
                const SizedBox(height: 16),

                // Champ de texte pour le nom
                _buildNameField(),
                const SizedBox(height: 20),
                // Champ de texte pour le téléphone
                _buildPhoneField(),
                const SizedBox(height: 20),
                // Sélecteur de date
                _buildDatePicker(),
                const SizedBox(height: 20),
                // Sélecteur d'heure
                _buildTimePicker(),
                const SizedBox(height: 20),
                // Champ de texte pour le nombre de personnes
                _buildNumberOfPeopleField(),
                const SizedBox(height: 20),

                // Bouton de confirmation
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Créer la nouvelle réservation

                        // Afficher un message de confirmation
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Réservation confirmée pour ${widget.restaurantName} !'),
                          ),
                        );

                        // Mettre à jour l'état de réservation confirmée
                        setState(() {
                          reservationConfirmed = true;
                        });

                        // Optionnel: Vous pouvez garder la réservation ici si vous le souhaitez
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00796B),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Confirmer la réservation',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),

                // Afficher le bouton "Voir mes réservations" si la réservation est confirmée
                if (reservationConfirmed)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Naviguer vers la page de liste des réservations
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ReservationListPage(
                                reservations: [],
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00796B),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          'Voir mes réservations',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
        );
        if (picked != null && picked != DateTime.now()) {
          setState(() {
            selectedDate = "${picked.toLocal()}".split(' ')[0];
          });
        }
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedDate ?? "Sélectionnez une date",
                style: const TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const Icon(Icons.calendar_today, color: Color(0xFF00796B)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return GestureDetector(
      onTap: () async {
        TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (picked != null) {
          setState(() {
            selectedTime = picked.format(context);
          });
        }
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedTime ?? "Sélectionnez une heure",
                style: const TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const Icon(Icons.access_time, color: Color(0xFF00796B)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberOfPeopleField() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: "Nombre de personnes",
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer le nombre de personnes'; // Message d'erreur
            }
            return null; // Pas d'erreur
          },
          onChanged: (value) {
            numberOfPeople = int.tryParse(value) ?? 2; // Par défaut 2
          },
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: "Nom",
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer votre nom'; // Message d'erreur
            }
            return null; // Pas d'erreur
          },
          onChanged: (value) {
            name = value; // Mettre à jour le nom
          },
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: "Téléphone",
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer votre numéro de téléphone'; // Message d'erreur
            }
            return null; // Pas d'erreur
          },
          onChanged: (value) {
            phone = value; // Mettre à jour le téléphone
          },
        ),
      ),
    );
  }
}
