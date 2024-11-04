import 'package:flutter/material.dart';
import 'package:reservation_service/pages/SousService/restaurantPage.dart';
import 'package:reservation_service/pages/SousService/screenSante.dart';
import 'package:reservation_service/pages/details/hotelPage.dart';
import 'package:reservation_service/pages/details/profil.dart';
import 'package:reservation_service/pages/detailsServices/reservationListPage.dart';
// Import de HealthPage

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

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

    if (index == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReservationListPage(
                    initialReservations: [],
                  )));
    } else if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfilePage()));
    }
  }

  void _navigateToService(String label) {
    if (label == 'Restaurants') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RestaurantPage()));
    } else if (label == 'Hôtels') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HotelPage()));
    } else if (label == 'Santé') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HealthPage())); // Navigation vers HealthPage
    } else if (label == 'Mes Réservations') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReservationListPage(
                    initialReservations: [],
                  )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vous avez sélectionné $label')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ServHubX'),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Bienvenue dans ServHubX!",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00796B))),
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
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Expanded(
                            child: Image.asset(
                                filteredServices[index]['image']!,
                                fit: BoxFit.cover)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(filteredServices[index]['label']!,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF00796B))),
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
        selectedItemColor: const Color(0xFF00796B),
        onTap: _onItemTapped,
      ),
    );
  }
}
