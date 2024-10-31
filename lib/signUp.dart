import 'package:flutter/material.dart';
import 'package:reservation_service/pages/HomePage.dart'; // Import de la page d'accueil
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import du package Font Awesome

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          'S\'inscrire',
          style: TextStyle(fontSize: 22),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () {
            Navigator.pop(context); // Retour à la page précédente
          },
        ),
      ),
      body: SingleChildScrollView(
        // Ajout d'un SingleChildScrollView
        child: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Créez votre Compte',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'Prénom',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    // Suppression de la validation
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Veuillez entrer votre prénom';
                    //   }
                    //   return null;
                    // },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email ou Téléphone',
                      prefixIcon: const Icon(Icons.mail_lock),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    // Suppression de la validation
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Veuillez entrer un email ou un téléphone';
                    //   }
                    //   return null;
                    // },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    // Suppression de la validation
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Veuillez entrer un mot de passe';
                    //   }
                    //   return null;
                    // },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirmez le mot de passe',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),

                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Veuillez confirmer le mot de passe';
                    //   }
                    //   if (value != _passwordController.text) {
                    //     return 'Les mots de passe ne correspondent pas';
                    //   }
                    //   return null;
                    // },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // Ici tu peux ajouter la logique d'inscription

                      // Naviguer vers la page d'accueil
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const HomePage()), // Redirige vers la page d'accueil
                      );
                    },
                    child: const Text('S\'inscrire'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Ou inscrivez-vous avec :',
                      textAlign: TextAlign.center),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.google, size: 30),
                        onPressed: () {
                          // Logique pour l'inscription avec Google
                        },
                        color: Colors.red,
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.facebook, size: 30),
                        onPressed: () {
                          // Logique pour l'inscription avec Facebook
                        },
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.apple, size: 30),
                        onPressed: () {
                          // Logique pour l'inscription avec Apple
                        },
                        color: Colors.black,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Retourne à la page de connexion
                    },
                    child: const Text(
                      'Vous avez déjà un compte? Connexion',
                      style:
                          TextStyle(color: Color.fromARGB(255, 101, 140, 212)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
