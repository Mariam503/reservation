import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importation du package intl
import 'package:reservation_service/firebase_serv/firebase_servConcert.dart';
import 'package:reservation_service/model/concert.dart';
import 'package:reservation_service/pages/detailsServices/reservationListPage.dart';

class ReservationPage extends StatefulWidget {
  final Map<String, int> ticketTypesWithPrices;
  final String ticketType;
  final Concert concert;

  const ReservationPage({
    Key? key,
    required this.concert,
    required this.ticketTypesWithPrices,
    required this.ticketType,
  }) : super(key: key);

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final _formKey = GlobalKey<FormState>();
  int _quantity = 1;
  bool _isLoading = false;
  String? _selectedTicketType;
  int _totalPrice = 0;
  String _selectedPaymentMethod = 'Carte bancaire'; // Mode de paiement

  @override
  void initState() {
    super.initState();
    _selectedTicketType = widget.ticketType;
    _calculateTotalPrice();
  }

  void _confirmReservation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmer la réservation'),
          content: Text(
              'Confirmez-vous votre réservation de $_quantity billet(s) de type "$_selectedTicketType" pour ${widget.concert.title} ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _makeReservation();
              },
              child: const Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }

  void _makeReservation() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Appel de la fonction Firestore pour ajouter une réservation
        await addReservation(
          serviceName: widget.concert.title,
          userName:
              'Nom de l\'utilisateur', // Remplacez par l'authentification Firebase si disponible
          reservationDate: DateTime.now(),
          numberOfGuests: _quantity,
          ticketType: _selectedTicketType!,
        );

        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Réservation confirmée !')),
          );

          // Redirection vers la page de liste des réservations
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const ReservationListPage(initialReservations: []),
            ),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur lors de la réservation : $e')),
          );
        }
      }
    }
  }

  void _calculateTotalPrice() {
    if (_selectedTicketType != null &&
        widget.ticketTypesWithPrices.containsKey(_selectedTicketType)) {
      setState(() {
        _totalPrice =
            widget.ticketTypesWithPrices[_selectedTicketType!]! * _quantity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Formatage de la date avec gestion d'erreur
    DateTime? concertDate = DateTime.tryParse(widget.concert.date);
    String formattedDate = concertDate != null
        ? DateFormat('dd/MM/yyyy HH:mm').format(concertDate.toLocal())
        : 'Date invalide';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.concert.title),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Réservez votre place pour ${widget.concert.title}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Détails du concert
              Text(
                'Date de l\'événement: $formattedDate',
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 10),
              Text(
                'Lieu: ${widget.concert.location}',
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 20),

              // Sélecteur de type de billet
              DropdownButtonFormField<String>(
                value: _selectedTicketType,
                decoration: const InputDecoration(
                  labelText: 'Type de billet',
                  border: OutlineInputBorder(),
                ),
                items: widget.ticketTypesWithPrices.keys
                    .map((ticketType) => DropdownMenuItem<String>(
                          value: ticketType,
                          child: Text(ticketType),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTicketType = value;
                    _calculateTotalPrice();
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner un type de billet';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Quantité
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: _quantity > 1
                        ? () {
                            setState(() {
                              _quantity--;
                              _calculateTotalPrice();
                            });
                          }
                        : null,
                  ),
                  Text(
                    'Quantité: $_quantity',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _quantity++;
                        _calculateTotalPrice();
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Affichage du prix total
              Text(
                'Prix total: $_totalPrice GNF',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Sélection du mode de paiement
              DropdownButtonFormField<String>(
                value: _selectedPaymentMethod,
                decoration: const InputDecoration(
                  labelText: 'Mode de paiement',
                  border: OutlineInputBorder(),
                ),
                items: ['Carte bancaire', 'PayPal', 'Virement bancaire']
                    .map((paymentMethod) => DropdownMenuItem<String>(
                          value: paymentMethod,
                          child: Text(paymentMethod),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner un mode de paiement';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Bouton de confirmation
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _confirmReservation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00796B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Confirmer la réservation',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
