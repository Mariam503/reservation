import 'package:flutter/material.dart';
import 'package:reservation_service/model/santemodel.dart';

class HealthSubServiceDetailPage extends StatelessWidget {
  final HealthSubService service;

  const HealthSubServiceDetailPage(this.service, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service.name),
        backgroundColor: Color(0xFF00796B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                service.imagePath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              service.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00796B),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              service.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Fonctionnalité de réservation
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF00796B),
                  ),
                  child: const Text(
                    "Réserver",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Fonctionnalité de contact (par exemple, appel)
                  },
                  child: const Text(
                    "Contacter",
                    style: TextStyle(color: Color(0xFF00796B)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
