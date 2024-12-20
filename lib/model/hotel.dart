class Hotel {
  final String name;
  final String image;
  final String description;
  final String address;
  final List<String> amenities;

  // Constructeur
  Hotel({
    required this.name,
    required this.image,
    required this.description,
    required this.address,
    required this.amenities,
  });

  // Méthode pour convertir un objet Hotel en Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'address': address,
      'amenities': amenities,
    };
  }

  // Méthode pour créer un objet Hotel à partir d'un Map
  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      name: map['name'],
      image: map['image'],
      description: map['description'],
      address: map['address'],
      amenities: List<String>.from(map['amenities']),
    );
  }
}
