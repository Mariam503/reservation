class Reservation {
  final String service;
  final String date;
  final String time;
  final String details;
  final String name; // Ajouté pour le nom
  final String phone; // Ajouté pour le téléphone

  Reservation({
    required this.service,
    required this.date,
    required this.time,
    required this.details,
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
        'service': service,
        'date': date,
        'time': time,
        'details': details,
        'name': name,
        'phone': phone,
      };

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      service: json['service'],
      date: json['date'],
      time: json['time'],
      details: json['details'],
      name: json['name'],
      phone: json['phone'],
    );
  }
}
