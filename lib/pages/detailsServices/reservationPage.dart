import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:validators/validators.dart'; // Importation du package validators
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class RestaurantReservationPage extends StatefulWidget {
  final String restaurantName;

  const RestaurantReservationPage({Key? key, required this.restaurantName})
      : super(key: key);

  @override
  _RestaurantReservationPageState createState() =>
      _RestaurantReservationPageState();
}

class _RestaurantReservationPageState extends State<RestaurantReservationPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _numberOfGuestsController =
      TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _paycardController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedMenu;
  String? _selectedPaymentMethod;
  final List<String> _menus = ["Menu 1", "Menu 2", "Menu 3"];
  final List<String> _paymentMethods = [
    "Carte bancaire",
    "Orange Money",
    "Paycard SLTP",
    "Aucune"
  ];

  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  void _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _validateForm();
      });
    }
  }

  void _selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
        _validateForm();
      });
    }
  }

  void _validateForm() {
    bool isValid = _userNameController.text.isNotEmpty &&
        _contactController.text.isNotEmpty &&
        _numberOfGuestsController.text.isNotEmpty &&
        _selectedDate != null &&
        _selectedTime != null &&
        _selectedMenu != null &&
        _selectedPaymentMethod != null;

    if (_selectedPaymentMethod == "Carte bancaire") {
      isValid &= _cardNumberController.text.isNotEmpty &&
          _expiryDateController.text.isNotEmpty &&
          _cvvController.text.isNotEmpty &&
          isCreditCard(_cardNumberController.text);
    }

    if (_selectedPaymentMethod == "Orange Money") {
      isValid &= isLength(_phoneNumberController.text,
          8); // Validation du numéro de téléphone (ex. 8 caractères)
    }

    if (_selectedPaymentMethod == "Paycard SLTP") {
      isValid &= _paycardController.text.isNotEmpty;
    }

    setState(() {
      _isFormValid = isValid;
    });
  }

  void _submitReservation() async {
    if (!_isFormValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Veuillez remplir tous les champs correctement."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Créer un document pour la réservation dans Firestore
      await FirebaseFirestore.instance.collection('reservations').add({
        'restaurant': widget.restaurantName,
        'userName': _userNameController.text,
        'contact': _contactController.text,
        'numberOfGuests': _numberOfGuestsController.text,
        'selectedDate': DateFormat('dd/MM/yyyy').format(_selectedDate!),
        'selectedTime': _selectedTime?.format(context),
        'selectedMenu': _selectedMenu,
        'paymentMethod': _selectedPaymentMethod,
        'cardNumber': _selectedPaymentMethod == "Carte bancaire"
            ? _cardNumberController.text
            : null,
        'expiryDate': _selectedPaymentMethod == "Carte bancaire"
            ? _expiryDateController.text
            : null,
        'cvv': _selectedPaymentMethod == "Carte bancaire"
            ? _cvvController.text
            : null,
        'phoneNumber': _selectedPaymentMethod == "Orange Money"
            ? _phoneNumberController.text
            : null,
        'paycard': _selectedPaymentMethod == "Paycard SLTP"
            ? _paycardController.text
            : null,
      });

      _showConfirmationDialog();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur lors de la réservation : $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text(
            "Votre réservation a été enregistrée avec succès.\n"
            "Mode de paiement : $_selectedPaymentMethod",
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Fermer la boîte de dialogue
                Navigator.of(context).pop();

                // Retour à la page d'accueil (en utilisant pushNamedAndRemoveUntil pour nettoyer la pile)
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Réservation - ${widget.restaurantName}"),
        backgroundColor: const Color(0xFF00796B),
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Informations personnelles
              Text(
                "Informations personnelles",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _userNameController,
                label: "Nom de l'utilisateur",
                hint: "Entrez votre nom complet",
                icon: Icons.person,
                onChanged: (value) => _validateForm(),
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _contactController,
                label: "Contact",
                hint: "Entrez votre email ou numéro de téléphone",
                icon: Icons.contact_phone,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => _validateForm(),
              ),
              const SizedBox(height: 20),
              // Détails de la réservation
              Text(
                "Détails de la réservation",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _numberOfGuestsController,
                label: "Nombre de places",
                hint: "Entrez le nombre d'invités",
                icon: Icons.people,
                keyboardType: TextInputType.number,
                onChanged: (value) => _validateForm(),
              ),
              const SizedBox(height: 12),
              _buildDateTimeRow(
                label: "Date",
                value: _selectedDate == null
                    ? "Non sélectionnée"
                    : DateFormat('dd/MM/yyyy').format(_selectedDate!),
                onPressed: _selectDate,
              ),
              const SizedBox(height: 12),
              _buildDateTimeRow(
                label: "Heure",
                value: _selectedTime == null
                    ? "Non sélectionnée"
                    : _selectedTime!.format(context),
                onPressed: _selectTime,
              ),
              const SizedBox(height: 12),
              _buildDropdown(
                label: "Sélectionnez un menu",
                value: _selectedMenu,
                items: _menus,
                onChanged: (value) {
                  setState(() {
                    _selectedMenu = value;
                    _validateForm();
                  });
                },
              ),
              const SizedBox(height: 12),
              _buildDropdown(
                label: "Mode de paiement",
                value: _selectedPaymentMethod,
                items: _paymentMethods,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                    _validateForm();
                  });
                },
              ),
              // Additional fields for payment method
              _buildPaymentFields(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isFormValid ? _submitReservation : null,
                child: const Text('Confirmer la réservation'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00796B),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildDateTimeRow({
    required String label,
    required String value,
    required VoidCallback onPressed,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$label: $value",
          style: TextStyle(fontSize: 16),
        ),
        ElevatedButton(
          onPressed: onPressed,
          child: Text("Sélectionner"),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildPaymentFields() {
    if (_selectedPaymentMethod == "Carte bancaire") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            controller: _cardNumberController,
            label: "Numéro de carte",
            hint: "Entrez le numéro de votre carte",
            icon: Icons.credit_card,
            keyboardType: TextInputType.number,
            onChanged: (value) => _validateForm(),
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _expiryDateController,
            label: "Date d'expiration",
            hint: "MM/AA",
            icon: Icons.date_range,
            keyboardType: TextInputType.datetime,
            onChanged: (value) => _validateForm(),
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _cvvController,
            label: "CVV",
            hint: "Entrez le CVV",
            icon: Icons.security,
            keyboardType: TextInputType.number,
            onChanged: (value) => _validateForm(),
          ),
        ],
      );
    } else if (_selectedPaymentMethod == "Orange Money") {
      return _buildTextField(
        controller: _phoneNumberController,
        label: "Numéro de téléphone",
        hint: "Entrez votre numéro de téléphone",
        icon: Icons.phone,
        keyboardType: TextInputType.phone,
        onChanged: (value) => _validateForm(),
      );
    } else if (_selectedPaymentMethod == "Paycard SLTP") {
      return _buildTextField(
        controller: _paycardController,
        label: "Numéro de paycard",
        hint: "Entrez le numéro de votre Paycard SLTP",
        icon: Icons.card_giftcard,
        keyboardType: TextInputType.number,
        onChanged: (value) => _validateForm(),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
