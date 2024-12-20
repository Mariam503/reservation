import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ReservationPage extends StatefulWidget {
  final String salonName;
  final String salonDescription;

  const ReservationPage({
    Key? key,
    required this.salonName,
    required this.salonDescription,
  }) : super(key: key);

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  // Function to pick the date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Function to pick the time (using Guinea's 24-hour format)
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // Function to save reservation to Firestore
  Future<void> _saveReservation() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedDate == null || _selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Veuillez sélectionner la date et l\'heure')),
        );
        return;
      }

      if (_selectedDate!.isBefore(DateTime.now())) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('La date ne peut pas être dans le passé')),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        final reservation = {
          'salon_name': widget.salonName,
          'salon_description': widget.salonDescription,
          'name': _nameController.text,
          'phone': _phoneController.text,
          'date': DateFormat('yyyy-MM-dd').format(_selectedDate!),
          'time': _selectedTime?.format(context),
          'created_at': FieldValue.serverTimestamp(),
        };

        await FirebaseFirestore.instance
            .collection('reservations')
            .add(reservation);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Réservation confirmée !')),
        );

        Navigator.pushReplacementNamed(context, '/');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Erreur lors de la réservation: ${e.toString()}')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Réservation pour ${widget.salonName}'),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                widget.salonName,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                widget.salonDescription,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              // Nom avec icône
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }
                  return null;
                },
              ),
              // Téléphone avec icône et format spécifique (ex : +224 pour Guinée)
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Numéro de téléphone',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un numéro de téléphone';
                  }
                  if (!RegExp(r'^\+?[0-9]{9}$').hasMatch(value)) {
                    return 'Le numéro de téléphone doit être valide en Guinée';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Sélection de la date
              Text(
                'Sélectionner la date',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => _selectDate(context),
                child: Text(
                  _selectedDate == null
                      ? 'Choisir la date'
                      : DateFormat('d MMM yyyy').format(_selectedDate!),
                ),
              ),
              const SizedBox(height: 16),
              // Sélection de l'heure
              Text(
                'Sélectionner l\'heure',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => _selectTime(context),
                child: Text(
                  _selectedTime == null
                      ? 'Choisir l\'heure'
                      : _selectedTime?.format(context) ?? '',
                ),
              ),
              const SizedBox(height: 16),
              // Affichage de l'indicateur de chargement
              if (_isLoading) const Center(child: CircularProgressIndicator()),
              // Bouton de confirmation
              if (!_isLoading)
                ElevatedButton(
                  onPressed: _saveReservation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00796B),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Confirmer la réservation',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
