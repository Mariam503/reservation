import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String userName;
  final String email;
  final String phoneNumber;

  const EditProfilePage({
    Key? key,
    required this.userName,
    required this.email,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  final _formKey = GlobalKey<FormState>(); // Pour validation des champs

  @override
  void initState() {
    super.initState();
    // Initialiser les contrôleurs avec les données actuelles du profil
    _nameController = TextEditingController(text: widget.userName);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phoneNumber);
  }

  @override
  void dispose() {
    // Libérer les contrôleurs lorsqu'ils ne sont plus utilisés
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier le Profil'),
        backgroundColor:  const Color(0xFF00796B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Utiliser une clé pour le formulaire
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un email';
                  }
                  // Vérification basique de format d'email
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Veuillez entrer un email valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Téléphone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un numéro de téléphone';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Envoyer les données modifiées à la page précédente
                    Navigator.pop(context, {
                      'name': _nameController.text,
                      'email': _emailController.text,
                      'phone': _phoneController.text,
                    });

                    // Afficher un message de confirmation
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Profil mis à jour avec succès'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                child: const Text('Enregistrer les modifications'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:  const Color(0xFF00796B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
