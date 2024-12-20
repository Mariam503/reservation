import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:reservation_service/model/modelPharmacy.dart';
import 'package:reservation_service/pages/detailsServices/sousSante/pharmacy/panier.dart';
import 'package:url_launcher/url_launcher.dart';

class PharmacieDetailsPage extends StatefulWidget {
  final Pharmacie pharmacie;

  const PharmacieDetailsPage({Key? key, required this.pharmacie})
      : super(key: key);

  @override
  _PharmacieDetailsPageState createState() => _PharmacieDetailsPageState();
}

class _PharmacieDetailsPageState extends State<PharmacieDetailsPage> {
  late List<int> quantities;
  List<Map<String, dynamic>> panier =
      []; // Liste pour stocker les articles du panier

  @override
  void initState() {
    super.initState();
    quantities = List<int>.filled(widget.pharmacie.medicaments.length, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pharmacie.nom,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: const Color(0xFF00796B),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Naviguer vers la page du panier avec les articles ajoutés
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PanierPage(
                    panier: panier, // Passe la liste correcte ici
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImage(widget.pharmacie.imageUrl),
                const SizedBox(height: 20),
                _buildMainButtons(),
                const SizedBox(height: 20),
                _buildSectionHeader("Coordonnées"),
                _buildInfoRow(Icons.location_on, widget.pharmacie.adresse),
                _buildInfoRow(Icons.phone, widget.pharmacie.telephone),
                const SizedBox(height: 20),
                _buildSectionHeader("Horaires"),
                const SizedBox(height: 8),
                _buildHorairesList(widget.pharmacie.horaires),
                const SizedBox(height: 20),
                _buildSectionHeader("Médicaments disponibles"),
                const SizedBox(height: 8),
                _buildMedicamentSlider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        imageUrl,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            color: Colors.grey[200],
            child: const Center(
              child: Text("Image non disponible"),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMainButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildIconButton(Icons.phone, "Appeler", () {
          _launchUrl("tel:${widget.pharmacie.telephone}");
        }),
        _buildIconButton(Icons.location_on, "Localisation", () {
          _launchUrl(
              "https://www.google.com/maps?q=${widget.pharmacie.adresse}");
        }),
        _buildIconButton(Icons.favorite, "Favoris", () {
          Fluttertoast.showToast(msg: "Ajouté aux favoris");
        }),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, String label, VoidCallback onPressed) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: const Color(0xFF00796B)),
          onPressed: onPressed,
        ),
        Text(
          label,
          style: const TextStyle(color: Color(0xFF00796B)),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF00796B)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildHorairesList(List<Horaire> horaires) {
    return Column(
      children: horaires.map((horaire) {
        return _buildInfoRow(
          Icons.access_time,
          "${horaire.jour} : ${horaire.heureOuverture} - ${horaire.heureFermeture.isEmpty ? 'Fermé' : horaire.heureFermeture}",
        );
      }).toList(),
    );
  }

  Widget _buildMedicamentSlider() {
    return CarouselSlider.builder(
      itemCount: widget.pharmacie.medicaments.length,
      itemBuilder: (context, index, realIndex) {
        final medicament = widget.pharmacie.medicaments[index];
        return _buildMedicamentSlide(medicament, index);
      },
      options: CarouselOptions(
        height: 250,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        aspectRatio: 16 / 9,
        viewportFraction: 0.9,
      ),
    );
  }

  Widget _buildMedicamentSlide(Medicament medicament, int index) {
    double totalPrice = medicament.prix * quantities[index];
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                medicament.imageUrl,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Text("Image non disponible"),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              medicament.nom,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Prix : ${totalPrice.toStringAsFixed(2)} GNF",
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (quantities[index] > 1) quantities[index]--;
                    });
                  },
                ),
                Text(
                  quantities[index].toString(),
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      quantities[index]++;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00796B),
              ),
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text("Ajouter au panier"),
              onPressed: () {
                setState(() {
                  panier.add({
                    'medicament': medicament,
                    'quantity': quantities[index],
                  });
                });
                Fluttertoast.showToast(
                  msg:
                      "${medicament.nom} ajouté au panier avec ${quantities[index]} unité(s)",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: "Impossible d'ouvrir le lien");
    }
  }
}
