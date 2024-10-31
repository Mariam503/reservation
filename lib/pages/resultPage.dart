import 'package:flutter/material.dart';

class SearchService {
  // Fonction pour afficher le dialogue de recherche
  static void showSearchDialog(
      BuildContext context, Function(String) onQueryChanged) {
    showDialog(
      context: context,
      builder: (context) {
        String query = '';

        return AlertDialog(
          title: const Text('Recherche'),
          content: TextField(
            decoration:
                const InputDecoration(hintText: 'Entrez votre recherche'),
            onChanged: (value) {
              query = value;
              onQueryChanged(query); // Appel de la fonction passée en paramètre
            },
            onSubmitted: (value) {
              Navigator.of(context)
                  .pop(); // Fermer le dialogue après la soumission
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer le dialogue sans action
              },
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
}
