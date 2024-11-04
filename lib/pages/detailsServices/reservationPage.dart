import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'reservationListPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ReservationPage extends StatefulWidget {
  final String restaurantName;

  const ReservationPage({Key? key, required this.restaurantName})
      : super(key: key);

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  String name = '';
  String phone = '';
  String? selectedDate;
  String? selectedTime;
  int numberOfPeople = 2;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            key: _formKey,
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
                _buildNameField(),
                const SizedBox(height: 20),
                _buildPhoneField(),
                const SizedBox(height: 20),
                _buildDatePicker(),
                const SizedBox(height: 20),
                _buildTimePicker(),
                const SizedBox(height: 20),
                _buildNumberOfPeopleField(),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _saveReservation();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00796B),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 32),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 5,
                    ),
                    child: const Text('Confirmer la réservation',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveReservation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> reservations = prefs.getStringList('reservations') ?? [];

    try {
      Map<String, String> newReservation = {
        'service': widget.restaurantName,
        'date': selectedDate ?? '',
        'time': selectedTime ?? '',
        'details': 'Pour $numberOfPeople personne(s)',
        'name': name,
        'phone': phone,
      };

      reservations.add(json.encode(newReservation));
      await prefs.setStringList('reservations', reservations);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Réservation confirmée pour ${widget.restaurantName} !'),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ReservationListPage(initialReservations: reservations),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la sauvegarde de la réservation: $e'),
        ),
      );
    }
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Nom'),
      validator: (value) =>
          value == null || value.isEmpty ? 'Veuillez entrer votre nom' : null,
      onChanged: (value) => setState(() {
        name = value;
      }),
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Téléphone'),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer votre numéro de téléphone';
        } else if (value.length < 8 || value.length > 15) {
          return 'Veuillez entrer un numéro de téléphone valide (8-15 chiffres)';
        }
        return null;
      },
      onChanged: (value) => setState(() {
        phone = value;
      }),
    );
  }

  Widget _buildDatePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Date :", style: TextStyle(fontSize: 18)),
        Text(selectedDate ?? "Aucune date sélectionnée"),
        ElevatedButton(
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              setState(() {
                selectedDate =
                    "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
              });
            }
          },
          child: const Text('Choisir une date'),
        ),
      ],
    );
  }

  Widget _buildTimePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Heure :", style: TextStyle(fontSize: 18)),
        Text(selectedTime ?? "Aucune heure sélectionnée"),
        ElevatedButton(
          onPressed: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) {
              setState(() {
                selectedTime =
                    "${pickedTime.hour}:${pickedTime.minute.toString().padLeft(2, '0')}";
              });
            }
          },
          child: const Text('Choisir une heure'),
        ),
      ],
    );
  }

  Widget _buildNumberOfPeopleField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Nombre de personnes :"),
        DropdownButton<int>(
          value: numberOfPeople,
          items: List.generate(10, (index) => index + 1)
              .map((value) => DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              numberOfPeople = value!;
            });
          },
        ),
      ],
    );
  }
}
