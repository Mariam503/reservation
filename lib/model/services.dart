class Service {
  final String name;
  final String imagePath;

  Service({required this.name, required this.imagePath});
}

final List<Service> services = [
  Service(name: 'Salons de coiffure', imagePath: 'images/cut.jpeg'),
  Service(name: 'Restaurants', imagePath: 'images/restaurant1.jpeg'),
  Service(name: 'Hôtels', imagePath: 'images/hotel1.jpeg'),
  Service(name: 'Concerts', imagePath: 'images/concert.jpg'),
  Service(name: 'Nettoyage', imagePath: 'images/nettoyage.jpeg'),
  Service(name: 'Santé', imagePath: 'images/sante.jpeg'),
];
