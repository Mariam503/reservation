import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({Key? key}) : super(key: key);

  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  String? _currentLocation;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }

  // Fonction pour obtenir la localisation
  Future<void> _getLocation() async {
    setState(() {
      _isLoading = true;
    });

    bool serviceEnabled;
    LocationPermission permission;

    // Vérifiez si les services de localisation sont activés
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _currentLocation = "Services de localisation désactivés.";
        _isLoading = false;
      });
      return;
    }

    // Vérifiez et demandez l'autorisation de localisation
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _currentLocation = "Permission de localisation refusée.";
          _isLoading = false;
        });
        return;
      }
    }

    try {
      // Obtenez la localisation actuelle
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentLocation =
            "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
      });
    } catch (e) {
      setState(() {
        _currentLocation = "Erreur de récupération de la localisation.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Fonction pour appeler le numéro d'urgence
  Future<void> _callEmergency(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Impossible de passer l\'appel.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appeler les Urgences"),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const Text(
                "Appel d'urgence",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _getLocation,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Obtenir ma localisation"),
              ),
              const SizedBox(height: 8),
              Text(
                _currentLocation ?? "Localisation non obtenue",
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _callEmergency(
                      "115"); // Remplacer par le numéro d'urgence local
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00796B),
                ),
                child: const Text(
                  "Appeler les Urgences",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _callEmergency("115"); // Numéro d'urgence
        },
        backgroundColor: const Color(0xFF00796B),
        child: const Icon(Icons.phone, color: Colors.white),
      ),
    );
  }
}
