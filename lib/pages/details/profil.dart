import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'editProfil.dart'; // Import de la page d'édition du profil

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Variables pour stocker les données du profil
  String userName = 'Diallo Mariama tanou';
  String email = 'diallomariamtanou28@gmail.com';
  String phoneNumber = '+224 627 55 03 34';

  @override
  void initState() {
    super.initState();
    _loadProfileData(); // Charger les données de profil au démarrage
  }

  // Charger les données du profil depuis SharedPreferences
  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? userName;
      email = prefs.getString('email') ?? email;
      phoneNumber = prefs.getString('phoneNumber') ?? phoneNumber;
    });
  }

  // Mettre à jour les données de profil lorsque l'utilisateur revient de la page d'édition
  void _updateProfile(
      String updatedName, String updatedEmail, String updatedPhone) {
    setState(() {
      userName = updatedName;
      email = updatedEmail;
      phoneNumber = updatedPhone;
    });
    _saveProfileData(); // Sauvegarder les modifications
  }

  // Sauvegarder les données du profil dans SharedPreferences
  Future<void> _saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
    await prefs.setString('email', email);
    await prefs.setString('phoneNumber', phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: const Color.fromARGB(255, 101, 140, 212),
      ),
      body: Padding(
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
            const Divider(),
            Text(
              'Nom : $userName',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Naviguer vers la page de modification du profil avec les données actuelles
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                      userName: userName,
                      email: email,
                      phoneNumber: phoneNumber,
                    ),
                  ),
                );
                if (result != null) {
                  // Mettre à jour le profil avec les nouvelles données
                  _updateProfile(
                      result['name'], result['email'], result['phone']);
                }
              },
              child: const Text('Modifier le Profil'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 101, 140, 212),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
