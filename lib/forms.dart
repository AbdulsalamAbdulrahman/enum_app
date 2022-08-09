// import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:enum_app/homepage.dart';

//form keys

//dynamic textfields
final List<TextEditingController> floorNoControllers = [];
final List<TextField> floorNoFields = [];
final List<TextEditingController> shopsperfloorControllers = [];
final List<TextField> shopsperfloorFields = [];
final List<TextEditingController> rateControllers = [];
final List<TextField> rateFields = [];

// final floorNo = floorNoControllers[1].text;
// final shopsperfloor = shopsperfloorControllers[1].text;
// final rate = rateControllers[1].text;

//Landlord
TextEditingController fullName = TextEditingController();
TextEditingController regName = TextEditingController();
TextEditingController nationality = TextEditingController(text: 'Nigeria');

TextEditingController resAddress = TextEditingController();
TextEditingController phone = TextEditingController();
TextEditingController busName = TextEditingController();
TextEditingController busAddress = TextEditingController();
TextEditingController dueDate = TextEditingController();
TextEditingController busRegNo = TextEditingController();
// TextEditingController tin = TextEditingController();
TextEditingController nin = TextEditingController();
TextEditingController kadIRSId = TextEditingController();
TextEditingController areaoffice = TextEditingController();

//Agent
TextEditingController agName = TextEditingController();
TextEditingController agAddress = TextEditingController();
TextEditingController agPhone = TextEditingController();
// TextEditingController agTin = TextEditingController();
TextEditingController agNin = TextEditingController();

//floors
TextEditingController first = TextEditingController();
TextEditingController second = TextEditingController();
TextEditingController third = TextEditingController();
TextEditingController fourth = TextEditingController();
TextEditingController fifth = TextEditingController();
TextEditingController sixth = TextEditingController();
TextEditingController seventh = TextEditingController();
TextEditingController eight = TextEditingController();
TextEditingController ninth = TextEditingController();
TextEditingController tenth = TextEditingController();

//Plaza info
// TextEditingController floorNo = TextEditingController();
TextEditingController totalshops = TextEditingController();
// TextEditingController shopsperfloor = TextEditingController();
TextEditingController noshops = TextEditingController();
// TextEditingController rate = TextEditingController();

//houses info
TextEditingController flats = TextEditingController();
TextEditingController rateH = TextEditingController();

// geo
TextEditingController geolong = TextEditingController();
TextEditingController geolat = TextEditingController();

Widget textField(
  controllerValue,
  String label,
  inputType,
) {
  return TextFormField(
    // validator: validateField,
    controller: controllerValue,
    keyboardType: inputType,
    decoration: decorate(label),
  );
}

// String? validateField(value) {
//   if (value.isEmpty) {
//     return "field is required";
//   }
//   return null;
// }

// String? validateD(value) {
//   if (value == 'Business Type' || value == 'Select Type of Rent') {
//     return "field is required";
//   }5
//   return null;
// }

InputDecoration decorate(String label) {
  return InputDecoration(
      labelText: label,
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(color: Colors.grey, width: 0.0),
      ),
      border: const OutlineInputBorder());
}

// Widget plazaInfo() {
//   return Column(children: <Widget>[
//     textField(floorNo, 'Floor Number', TextInputType.text),
//     const SizedBox(
//       height: 20,
//     ),
//     textField(shops, 'Shops per floor', TextInputType.text),
//     const SizedBox(
//       height: 20,
//     ),
//     textField(rate, 'Rate', TextInputType.text),
//   ]);
// }

Widget housesInfo() {
  return Column(
    children: <Widget>[
      textField(flats, 'No. of flats', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(rateH, 'Rate', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}

Widget identiTin() {
  return textField(nin, 'TIN', TextInputType.text);
}

Widget identiNin() {
  return textField(nin, 'NIN', TextInputType.text);
}

Widget agidentiTin() {
  return textField(agNin, 'TIN', TextInputType.text);
}

Widget agidentiNin() {
  return textField(agNin, 'NIN', TextInputType.text);
}
