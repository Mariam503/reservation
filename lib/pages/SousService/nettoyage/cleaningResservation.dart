import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reservation_service/model/cleanning.dart';

class CleaningServiceReservationPage extends StatefulWidget {
  final String serviceName;

  CleaningServiceReservationPage({required this.serviceName});

  @override
  _CleaningServiceReservationPageState createState() =>
      _CleaningServiceReservationPageState();
}

class _CleaningServiceReservationPageState
    extends State<CleaningServiceReservationPage> {
  final _formKey = GlobalKey<FormState>();
  String _address = '';
  String _phoneNumber = '';
  String _date = '';
  String _time = '';
  String _cleaningType = '';
  String _additionalInfo = '';
  String _areaSize = '';
  String _paymentMethod = '';
  bool _isLoading = false;

  // Variables pour le prix et les types de nettoyage
  double _price = 0.0;

  // Controllers pour la date et l'heure
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  // Picker pour la date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
        _date = _dateController.text;
      });
    }
  }

  // Picker pour l'heure
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
        _time = _timeController.text;
      });
    }
  }

  // Fonction pour afficher le champ de texte
  Widget _buildTextField({
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    TextEditingController? controller,
    bool readOnly = false,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onSaved: onSaved,
        validator: validator,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Color(0xFF00796B)),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Fonction pour mettre à jour le prix en fonction du type de nettoyage
  void _updatePrice(String type) {
    switch (type) {
      case 'Nettoyage à domicile':
        setState(() {
          _price = 50000.0; // Prix par défaut pour le nettoyage à domicile
        });
        break;
      case 'Nettoyage de vitres':
        setState(() {
          _price = 30000.0; // Prix pour le nettoyage de vitres
        });
        break;
      case 'Nettoyage de tapis':
        setState(() {
          _price = 70000.0; // Prix pour le nettoyage de tapis
        });
        break;
      default:
        setState(() {
          _price = 0.0; // Aucun prix si aucun type n'est sélectionné
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Réserver un service de nettoyage'),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Réservation pour: ${widget.serviceName}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Affichage du prix en fonction du type de nettoyage
              if (_cleaningType.isNotEmpty)
                Text(
                  'Prix du service: \$${_price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              SizedBox(height: 20),

              // Adresse de service
              _buildTextField(
                label: 'Adresse de service',
                icon: Icons.location_on,
                onSaved: (value) => _address = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer l\'adresse';
                  }
                  return null;
                },
              ),

              // Numéro de téléphone
              _buildTextField(
                label: 'Numéro de téléphone',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                onSaved: (value) => _phoneNumber = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre numéro de téléphone';
                  }
                  return null;
                },
              ),

              // Date de réservation
              _buildTextField(
                label: 'Date de réservation',
                icon: Icons.calendar_today,
                controller: _dateController,
                readOnly: true,
                onTap: () => _selectDate(context),
                onSaved: (value) => _date = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la date de réservation';
                  }
                  return null;
                },
              ),

              // Heure de réservation
              _buildTextField(
                label: 'Heure de réservation',
                icon: Icons.access_time,
                controller: _timeController,
                readOnly: true,
                onTap: () => _selectTime(context),
                onSaved: (value) => _time = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer l\'heure';
                  }
                  return null;
                },
              ),

              // Type de nettoyage avec mise à jour du prix
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Type de nettoyage'),
                items: [
                  'Nettoyage à domicile',
                  'Nettoyage de vitres',
                  'Nettoyage de tapis'
                ].map((service) {
                  return DropdownMenuItem<String>(
                    value: service,
                    child: Text(service),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _cleaningType = value!;
                    _updatePrice(value); // Mettre à jour le prix
                  });
                },
                onSaved: (value) => _cleaningType = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner un type de nettoyage';
                  }
                  return null;
                },
              ),

              // Taille de la surface à nettoyer
              _buildTextField(
                label: 'Surface (en m²)',
                icon: Icons.square_foot,
                keyboardType: TextInputType.number,
                onSaved: (value) => _areaSize = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la taille de la surface';
                  }
                  final area = double.tryParse(value);
                  if (area == null || area <= 0) {
                    return 'Veuillez entrer une surface valide';
                  }
                  return null;
                },
              ),

              // Informations supplémentaires
              _buildTextField(
                label: 'Informations supplémentaires',
                icon: Icons.info,
                onSaved: (value) => _additionalInfo = value!,
                validator: (value) => null,
              ),

              // Méthode de paiement
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Méthode de paiement'),
                items: ['Carte', 'Espèces', 'Autre'].map((payment) {
                  return DropdownMenuItem<String>(
                    value: payment,
                    child: Text(payment),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value!;
                  });
                },
                onSaved: (value) => _paymentMethod = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner une méthode de paiement';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              // Bouton de soumission
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submitReservation,
                      child: Text('Confirmer la réservation'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF00796B),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitReservation() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Création d'un objet Reservation
      var reservation = Reservation(
        serviceName: widget.serviceName,
        address: _address,
        phoneNumber: _phoneNumber,
        date: _date,
        time: _time,
        cleaningType: _cleaningType,
        areaSize: _areaSize,
        additionalInfo: _additionalInfo,
        paymentMethod: _paymentMethod,
        price: _price,
        createdAt: Timestamp.now(),
      );

      setState(() {
        _isLoading = true;
      });

      try {
        // Ajouter la réservation à Firestore
        await FirebaseFirestore.instance
            .collection('reservations')
            .add(reservation.toMap());

        setState(() {
          _isLoading = false;
        });

        // Afficher une boîte de dialogue de succès
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Réservation confirmée !'),
            content: Text('Votre réservation a été effectuée avec succès.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fermer la boîte de dialogue
                  Navigator.of(context)
                      .pop(); // Retourner à la page précédente ou d'accueil
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        // Afficher un message d'erreur
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de l\'envoi des données.')),
        );
      }
    }
  }
}
