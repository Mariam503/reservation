// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:reservation_service/model/reservationList.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class EditReservationPage extends StatefulWidget {
//   final Reservation reservation;

//   const EditReservationPage({Key? key, required this.reservation})
//       : super(key: key);

//   @override
//   _EditReservationPageState createState() => _EditReservationPageState();
// }

// class _EditReservationPageState extends State<EditReservationPage> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _serviceController;
//   late TextEditingController _dateController;
//   late TextEditingController _timeController;
//   late TextEditingController _detailsController;
//   late TextEditingController _nameController;
//   late TextEditingController _phoneController;

//   final Color primaryColor = Color(0xFF00796B);

//   @override
//   void initState() {
//     super.initState();
//     _serviceController =
//         TextEditingController(text: widget.reservation.service);
//     _dateController = TextEditingController(text: widget.reservation.date);
//     _timeController = TextEditingController(text: widget.reservation.time);
//     _detailsController =
//         TextEditingController(text: widget.reservation.details);
//     _nameController = TextEditingController(text: widget.reservation.name);
//     _phoneController = TextEditingController(text: widget.reservation.phone);
//   }

//   @override
//   void dispose() {
//     _serviceController.dispose();
//     _dateController.dispose();
//     _timeController.dispose();
//     _detailsController.dispose();
//     _nameController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }

//   Future<void> _selectDate() async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );
//     if (pickedDate != null) {
//       setState(() {
//         _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
//       });
//     }
//   }

//   Future<void> _selectTime() async {
//     TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (pickedTime != null) {
//       setState(() {
//         _timeController.text = pickedTime.format(context);
//       });
//     }
//   }

//   void _saveChanges() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       List<String> reservations = prefs.getStringList('reservations') ?? [];

//       Reservation updatedReservation = Reservation(
//         service: _serviceController.text,
//         date: _dateController.text,
//         time: _timeController.text,
//         details: _detailsController.text,
//         name: _nameController.text,
//         phone: _phoneController.text,
//         id: '',
//       );

//       reservations
//           .removeWhere((r) => r == json.encode(widget.reservation.toJson()));
//       reservations.add(json.encode(updatedReservation.toJson()));
//       await prefs.setStringList('reservations', reservations);

//       Navigator.pop(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Modifier la réservation'),
//         backgroundColor: primaryColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildTextField(_serviceController, 'Service'),
//               const SizedBox(height: 10),
//               _buildDateTimeField(_dateController, 'Date', _selectDate),
//               const SizedBox(height: 10),
//               _buildDateTimeField(_timeController, 'Heure', _selectTime),
//               const SizedBox(height: 10),
//               _buildTextField(_detailsController, 'Détails'),
//               const SizedBox(height: 10),
//               _buildTextField(_nameController, 'Nom'),
//               const SizedBox(height: 10),
//               _buildTextField(_phoneController, 'Téléphone'),
//               const SizedBox(height: 20),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: _saveChanges,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: primaryColor,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 50, vertical: 15),
//                   ),
//                   child: const Text(
//                     'Sauvegarder les modifications',
//                     style: TextStyle(fontSize: 16, color: Colors.black),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(TextEditingController controller, String labelText) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: labelText,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: primaryColor),
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Veuillez entrer $labelText';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildDateTimeField(
//       TextEditingController controller, String labelText, Function onTap) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: labelText,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: primaryColor),
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         suffixIcon: Icon(Icons.calendar_today, color: primaryColor),
//       ),
//       readOnly: true,
//       onTap: () => onTap(),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Veuillez sélectionner $labelText';
//         }
//         return null;
//       },
//     );
//   }
// }
