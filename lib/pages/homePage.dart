import 'package:flutter/material.dart';
import 'package:reservation_service/pages/SousService/restaurantPage.dart';
import 'package:reservation_service/pages/SousService/screenSante.dart';
import 'package:reservation_service/pages/details/hotelPage.dart';
import 'package:reservation_service/pages/details/profil.dart';
import 'package:reservation_service/pages/detailsServices/reservationListPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final Color _primaryColor = const Color(0xFF00796B);

  final List<Map<String, String>> services = [
    {'image': 'images/cut.jpeg', 'label': 'Salons de coiffure'},
    {'image': 'images/restaurant1.jpeg', 'label': 'Restaurants'},
    {'image': 'images/hotel1.jpeg', 'label': 'Hôtels'},
    {'image': 'images/concert.jpg', 'label': 'Concerts'},
    {'image': 'images/nettoyage.jpeg', 'label': 'Nettoyage'},
    {'image': 'images/sante.jpeg', 'label': 'Santé'}, // Catégorie Santé
    {'image': 'images/reservations.jpeg', 'label': 'Mes Réservations'},
  ];

  List<Map<String, String>> filteredServices = [];

  @override
  void initState() {
    super.initState();
    filteredServices = services;
  }

  void _filterServices(String query) {
    setState(() {
      filteredServices = query.isEmpty
          ? services
          : services
              .where((service) =>
                  service['label']!.toLowerCase().contains(query.toLowerCase()))
              .toList();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReservationListPage(initialReservations: []),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
    }
  }

  void _navigateToService(String label) {
    Widget page;
    switch (label) {
      case 'Restaurants':
        page = RestaurantPage();
        break;
      case 'Hôtels':
        page = HotelPage();
        break;
      case 'Santé':
        page = HealthPage();
        break;
      case 'Mes Réservations':
        page = ReservationListPage(initialReservations: []);
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vous avez sélectionné $label')),
        );
        return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ServHubX'),
        backgroundColor: _primaryColor,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Bienvenue dans ServHubX!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00796B),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: filteredServices.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () =>
                      _navigateToService(filteredServices[index]['label']!),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            filteredServices[index]['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            filteredServices[index]['label']!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_online), label: 'Réservations'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Profil'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: _primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
