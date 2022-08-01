import 'package:flutter/material.dart';

//Landlord
TextEditingController fullName = TextEditingController();
TextEditingController regName = TextEditingController();
TextEditingController nationality = TextEditingController();
TextEditingController resAddress = TextEditingController();
TextEditingController phone = TextEditingController();
TextEditingController busName = TextEditingController();
TextEditingController busAddress = TextEditingController();
TextEditingController dueDate = TextEditingController();
TextEditingController busRegNo = TextEditingController();
TextEditingController tin = TextEditingController();
TextEditingController kadIRSId = TextEditingController();

//Agent
TextEditingController agName = TextEditingController();
TextEditingController agAddress = TextEditingController();
TextEditingController agPhone = TextEditingController();

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

//plazas info
TextEditingController floors = TextEditingController();
TextEditingController shops = TextEditingController();
TextEditingController rate = TextEditingController();

//houses info
TextEditingController flats = TextEditingController();
TextEditingController rateH = TextEditingController();

Widget textField(controllerValue, String label, inputType) {
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
//   }
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

Widget firstFloor() {
  return Column(
    children: <Widget>[
      textField(first, 'First Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}

Widget secondFloor() {
  return Column(
    children: <Widget>[
      textField(first, 'First Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(second, 'Second Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}

Widget thirdFloor() {
  return Column(
    children: <Widget>[
      textField(first, 'First Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(second, 'Second Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(third, 'Third Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}

Widget fourthFloor() {
  return Column(
    children: <Widget>[
      textField(first, 'First Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(second, 'Second Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(third, 'Third Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(fourth, 'Fourth Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}

Widget fifthFloor() {
  return Column(
    children: <Widget>[
      textField(first, 'First Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(second, 'Second Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(third, 'Third Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(fourth, 'Fourth Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(fifth, 'Fifth Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}

Widget sixthFloor() {
  return Column(
    children: <Widget>[
      textField(first, 'First Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(second, 'Second Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(third, 'Third Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(fourth, 'Fourth Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(fifth, 'Fifth Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(sixth, 'Sixth Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}

Widget seventhFloor() {
  return Column(
    children: <Widget>[
      textField(first, 'First Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(second, 'Second Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(third, 'Third Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(fourth, 'Fourth Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(fifth, 'Fifth Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(sixth, 'Sixth Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(seventh, 'Seventh Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}

Widget eightFloor() {
  return Column(
    children: <Widget>[
      textField(first, 'First Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(second, 'Second Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(third, 'Third Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(fourth, 'Fourth Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(fifth, 'Fifth Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(sixth, 'Sixth Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(seventh, 'Seventh Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(eight, 'Eight Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}

Widget ninthFloor() {
  return Column(
    children: <Widget>[
      textField(first, 'First Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(second, 'Second Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(third, 'Third Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(fourth, 'Fourth Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(fifth, 'Fifth Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(sixth, 'Sixth Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(seventh, 'Seventh Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(eight, 'Eight Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(ninth, 'Ninth Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}

Widget tenthFloor() {
  return Column(
    children: <Widget>[
      textField(first, 'First Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(second, 'Second Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(third, 'Third Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(fourth, 'Fourth Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(fifth, 'Fifth Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(sixth, 'Sixth Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(seventh, 'Seventh Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(eight, 'Eight Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(ninth, 'Ninth Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(tenth, 'Tenth Floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}

Widget plazaInfo() {
  return Column(
    children: <Widget>[
      // textField(floors, 'Number of Floors', TextInputType.text),
      // const SizedBox(
      //   height: 20,
      // ),
      textField(shops, 'Shops per floor', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
      textField(rate, 'Rate', TextInputType.text),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}

Widget housesInfo() {
  return Column(
    children: <Widget>[
      // textField(floors, 'Number of Floors', TextInputType.text),
      // const SizedBox(
      //   height: 20,
      // ),
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
