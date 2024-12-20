import 'package:flutter/material.dart';

class SalonCard extends StatelessWidget {
  final String name;
  final String description;
  final String image;
  final VoidCallback onTap;

  const SalonCard({
    Key? key,
    required this.name,
    required this.description,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: 1.0, // Vous pouvez ajouter un état pour gérer le tap ici
        duration: const Duration(milliseconds: 150),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Semantics(
            label:
                "Salon: $name, Description: $description", // Label pour l'accessibilité
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // L'image doit occuper tout l'espace disponible en haut de la carte
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1.5, // Définir un ratio pour l'image
                    child: Image.asset(
                      image, // Utilisation d'une image locale
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Contenu sous l'image
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nom du salon
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00796B), // Couleur spécifique
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Description du salon
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow
                            .ellipsis, // Ajoutez un ellipsis si le texte est trop long
                      ),
                    ],
                  ),
                ),
                // Ajoutez des icônes d'actions (ex : favoris ou partage)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {
                          // Action pour ajouter aux favoris
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () {
                          // Action pour partager
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
