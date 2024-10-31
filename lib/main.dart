// import 'package:flutter/material.dart';
// import 'package:reservation_service/pages/homePage.dart';
// // Assure-toi que ce chemin pointe correctement vers ton fichier

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false, // Supprime le badge de débogage
//       title: 'ServHubX',
//       theme: ThemeData(
//         primarySwatch: Colors.blue, // Définir les couleurs principales
//       ),
//       home: const HomePage(), // Appelle la page d'accueil ici
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:reservation_service/LoginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
