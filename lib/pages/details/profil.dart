import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String userName = '';
  String email = '';
  String phoneNumber = '';
  String profileImageUrl = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      User? user = _auth.currentUser;
      print(user);
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Aucun utilisateur connecté.")),
        );
        return;
      }

      // Récupération du document utilisateur
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          userName = userDoc['name'] ?? 'Nom inconnu';
          email = userDoc['email'] ?? 'Email inconnu';
          phoneNumber = userDoc['phone'] ?? 'Téléphone inconnu';
          profileImageUrl = userDoc['profileImageUrl'] ?? '';
          isLoading = false; // Fin du chargement
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profil utilisateur introuvable.")),
        );
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Erreur Firestore : $e"); // Log dans la console
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors du chargement du profil : $e")),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator()) // Affichage du loader pendant le chargement
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('images/profile_picture.png'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (profileImageUrl
                      .isNotEmpty) // Si l'URL de l'image de profil est disponible, on l'affiche
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(profileImageUrl),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    'Nom : $userName',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Email : $email',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Téléphone : $phoneNumber',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
    );
  }
}
