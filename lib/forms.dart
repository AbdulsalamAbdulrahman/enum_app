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

//dynamic textfields 2
final List<TextEditingController> housetypeControllers = [];
final List<TextField> housetypeFields = [];
final List<TextEditingController> nohouseControllers = [];
final List<TextField> nohouseFields = [];
final List<TextEditingController> rateEstateControllers = [];
final List<TextField> rateEstateFields = [];

// final floorNo = floorNoControllers[1].text;
// final shopsperfloor = shopsperfloorControllers[1].text;
// final rate = rateControllers[1].text;

//Landlord
TextEditingController fullName = TextEditingController();
TextEditingController regName = TextEditingController();
TextEditingController nationality = TextEditingController(text: 'Nigeria');

TextEditingController resAddress = TextEditingController();
TextEditingController phone = TextEditingController();
TextEditingController busType = TextEditingController();
TextEditingController busAddress = TextEditingController();
TextEditingController dueDate = TextEditingController();
TextEditingController busRegNo = TextEditingController();
// TextEditingController tin = TextEditingController();
TextEditingController nin = TextEditingController();
TextEditingController kadIRSId = TextEditingController();
// TextEditingController areaoffice = TextEditingController();

//Agent
TextEditingController agName = TextEditingController();
TextEditingController agMail = TextEditingController();
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

//estate/compound
TextEditingController housetype = TextEditingController();
TextEditingController nohouse = TextEditingController();
TextEditingController rateEstate = TextEditingController();

//others
TextEditingController renType = TextEditingController();
TextEditingController units = TextEditingController();
TextEditingController rpu = TextEditingController();

// geo
TextEditingController geolong = TextEditingController();
TextEditingController geolat = TextEditingController();

Widget textField(
  controllerValue,
  String label,
  inputType,
) {
  return TextFormField(
    validator: validateField,
    controller: controllerValue,
    keyboardType: inputType,
    decoration: decorate(label),
  );
}

String? validateField(value) {
  if (value.isEmpty) {
    return "field is required";
  }
  return null;
}

String? validateD(value) {
  if (value == 'Select Type of Rent') {
    return "field is required";
  }
  return null;
}

String? validateG(value) {
  if (value.isEmpty) {
    return "field is required, switch on your location";
  }
  return null;
}

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
      textField(flats, 'No. of flats', TextInputType.number),
      const SizedBox(
        height: 20,
      ),
      textField(rateH, 'Rate', TextInputType.number),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}

Widget identiTin() {
  return textField(nin, 'Taxpayer Identification No', TextInputType.number);
}

Widget identiNin() {
  return textField(nin, 'National Identification No', TextInputType.number);
}

Widget agidentiTin() {
  return textField(agNin, 'Taxpayer Identification No', TextInputType.number);
}

Widget agidentiNin() {
  return textField(agNin, 'National Identification No', TextInputType.number);
}
