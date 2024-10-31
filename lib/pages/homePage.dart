import 'package:flutter/material.dart';
import 'package:reservation_service/LoginScreen.dart';
import 'package:reservation_service/pages/SousService/restaurantPage.dart';
import 'package:reservation_service/pages/details/hotelPage.dart';
import 'package:reservation_service/pages/details/profil.dart';
import 'package:reservation_service/pages/details/reservation.dart';
import 'package:reservation_service/pages/resultPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Liste des services avec image et label
  final List<Map<String, String>> services = [
    {'image': 'images/cut.jpeg', 'label': 'Salons de coiffure'},
    {'image': 'images/restaurant1.jpeg', 'label': 'Restaurants'},
    {'image': 'images/hotel1.jpeg', 'label': 'Hôtels'},
    {'image': 'images/concert.jpg', 'label': 'Concerts'},
    {'image': 'images/nettoyage.jpeg', 'label': 'Nettoyage'},
    {'image': 'images/sante.jpeg', 'label': 'Santé'},
  ];

  List<Map<String, String>> filteredServices = [];

  @override
  void initState() {
    super.initState();
    filteredServices = services;
  }

  void _filterServices(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredServices = services;
      } else {
        filteredServices = services
            .where((service) =>
                service['label']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ReservationListPage(reservations: [])),
      );
    }
  }

  void _navigateToService(String label) {
    if (label == 'Restaurants') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RestaurantPage()),
      );
    } else if (label == 'Hôtels') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HotelPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vous avez sélectionné $label')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ServHubX'),
        backgroundColor: const Color(0xFF00796B),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Supposons que vous ayez une fonction `showSearchDialog` dans un autre fichier
              SearchService.showSearchDialog(context, _filterServices);
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'paramètre') {
                // Logique pour les paramètres
              } else if (value == 'About') {
                _showAboutDialog(context);
              } else if (value == 'Déconnexion') {
                _logOut(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return {'paramètre', 'About', 'Déconnexion'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Catégories de services',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: filteredServices.map((service) {
                  return _buildCategoryCard(
                      service['image']!, service['label']!, context);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book), label: 'Réservations'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildCategoryCard(
      String imagePath, String label, BuildContext context) {
    return InkWell(
      onTap: () {
        _navigateToService(label);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black.withOpacity(0.6),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('À propos'),
          content: const Text(
              'Cette application vous permet de réserver divers services.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  void _logOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Déconnexion'),
          content: const Text('Voulez-vous vraiment vous déconnecter ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Non'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text('Oui'),
            ),
          ],
        );
      },
    );
  }
}
