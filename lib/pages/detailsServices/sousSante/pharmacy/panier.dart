import 'package:flutter/material.dart';

class PanierPage extends StatelessWidget {
  final List<Map<String, dynamic>> panier;

  const PanierPage({Key? key, required this.panier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double total = panier.fold(0.0, (sum, item) {
      return sum + (item['medicament'].prix * item['quantity']);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon Panier"),
        backgroundColor: Colors.teal,
      ),
      body: panier.isEmpty
          ? Center(
              child: Text(
                "Votre panier est vide",
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: panier.length,
                    itemBuilder: (context, index) {
                      final medicament = panier[index]['medicament'];
                      final quantity = panier[index]['quantity'];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Image.network(
                            medicament.imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(medicament.nom),
                          subtitle: Text(
                            "Prix: ${(medicament.prix * quantity).toStringAsFixed(2)} GNF\nQuantité: $quantity",
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // Gérer la suppression
                              panier.removeAt(index);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PanierPage(panier: panier),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total : ${total.toStringAsFixed(2)} GNF",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Commande validée avec succès!"),
                            ),
                          );
                        },
                        child: const Text("Commander"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
