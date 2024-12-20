import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:reservation_service/model/users.dart'; // Remplacez ce modèle par votre propre modèle si nécessaire

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Récupérer les informations de l'utilisateur à partir de Firestore
  Future<UserModel?> getUser(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('profil').doc(uid).get();

      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        return null; // Retourner null si le document n'existe pas
      }
    } catch (e) {
      print("Erreur lors de la récupération du profil : $e");
      return null;
    }
  }
}
