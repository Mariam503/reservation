import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reservation_service/LoginScreen.dart';
import 'package:reservation_service/collectionFirebase/ueser_service.dart';
import 'package:reservation_service/model/users.dart'; // Assurez-vous que ce modèle est importé correctement

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();

  UserModel? userModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        _showSnackBar("Aucun utilisateur connecté.");
        return;
      }

      UserModel? userData = await _userService.getUser(user.uid);
      if (userData != null) {
        setState(() {
          userModel = userData;
          isLoading = false;
        });
      } else {
        _showSnackBar("Profil utilisateur introuvable.");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Erreur lors du chargement du profil : $e");
      _showSnackBar("Une erreur est survenue. Veuillez réessayer plus tard.");
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: "Déconnexion",
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userModel == null
              ? const Center(
                  child: Text("Aucune donnée utilisateur disponible."))
              : _buildUserProfile(userModel!),
    );
  }

  Widget _buildUserProfile(UserModel user) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: user.profileImageUrl != null &&
                    user.profileImageUrl!.isNotEmpty
                ? NetworkImage(
                    user.profileImageUrl!) // Si une URL d'image est présente
                : const AssetImage('images/profile_picture.png')
                    as ImageProvider, // Image par défaut
          ),
          const SizedBox(height: 20),
          Text("Nom : ${user.firstName}"),
          Text("Email : ${user.email}"),
          Text("Date de création : ${user.createdAt.toLocal()}"),
        ],
      ),
    );
  }

  Future<void> _logout() async {
    try {
      await _auth.signOut(); // Déconnexion de Firebase
      // Rediriger vers la page de connexion après déconnexion
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false, // Supprime toutes les pages précédentes
      );
    } catch (e) {
      debugPrint("Erreur de déconnexion : $e");
      _showSnackBar("Une erreur est survenue lors de la déconnexion.");
    }
  }
}
