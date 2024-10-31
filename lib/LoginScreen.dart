import 'package:flutter/material.dart';
import 'package:reservation_service/pages/HomePage.dart'; // Import de la page d'accueil
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reservation_service/signUp.dart'; // Import du package Font Awesome

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      'Bienvenue au ServHubX !',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email ou Téléphone',
                        prefixIcon: const Icon(Icons.mail_lock),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un email ou un téléphone';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un mot de passe';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HomePage()),
                          );
                        }
                      },
                      child: const Text('Se Connecter'),
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
                    const Text('Ou connectez-vous avec :',
                        textAlign: TextAlign.center),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.google, size: 30),
                          onPressed: () {
                            // Logique pour la connexion avec Google
                          },
                          color: Colors.red,
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.facebook, size: 30),
                          onPressed: () {
                            // Logique pour la connexion avec Facebook
                          },
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.apple, size: 30),
                          onPressed: () {
                            // Logique pour la connexion avec Apple
                          },
                          color: Colors.black,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        // Naviguer vers la page d'inscription sans bouton sur la page d'accueil
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Pas encore de compte? Inscrivez-vous',
                        style: TextStyle(
                            color: Color.fromARGB(255, 101, 140, 212)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
