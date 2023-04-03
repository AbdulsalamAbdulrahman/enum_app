import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Unavailable extends StatefulWidget {
  const Unavailable({super.key});

  @override
  State<Unavailable> createState() => _UnavailableState();
}

class _UnavailableState extends State<Unavailable> {
  final key = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _isLoadingG = false;

  String agentName = '',
      agentPhone = '',
      propertyName = '',
      propertyAddress = '';

  late bool error, sending, success;
  late String msg;

  //geo
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "";
  String lat = "";

  // geo
  TextEditingController geolong = TextEditingController();
  TextEditingController geolat = TextEditingController();

  getLocation() async {
    setState(() {
      _isLoadingG = true;
    });
    position = await Geolocator.getCurrentPosition(
        // forceAndroidLocationManager: true,
        desiredAccuracy: LocationAccuracy.high);
    // print(position.longitude); //Output: 80.24599079
    // print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    debugPrint("$long, $lat");

    setState(() {
      geolong.text = long;
      geolat.text = lat;
    });
    setState(() {
      _isLoadingG = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unavailable Page'),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Form(
          key: key,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                agentsName(),
                const SizedBox(
                  height: 20,
                ),
                agentsPhone(),
                const SizedBox(
                  height: 20,
                ),
                propertysName(),
                const SizedBox(
                  height: 20,
                ),
                propertysAddress(),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: validateG,
                  decoration: decorate('longitude'),
                  controller: geolong,
                  readOnly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: validateG,
                  decoration: decorate('latitude'),
                  controller: geolat,
                  readOnly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  icon: _isLoadingG
                      ? const SizedBox(
                          height: 15.0,
                          width: 15.0,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(''),
                  label: Text(
                    _isLoadingG ? '' : 'Get Geo Location',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(500, 50),
                    maximumSize: const Size(500, 50),
                  ),
                  onPressed: () async {
                    getLocation();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  icon: _isLoading
                      ? const SizedBox(
                          height: 15.0,
                          width: 15.0,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(''),
                  label: Text(
                    _isLoading ? '' : 'Submit',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(500, 50),
                    maximumSize: const Size(500, 50),
                  ),
                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      key.currentState!.save();
                      submitData();
                      debugPrint(agentName);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget agentsName() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Agent\'s Name',
        hintText: 'Enter Agent\'s Name',
        prefixIcon: const Icon(Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(),
        ),
      ),
      onSaved: (value) => agentName = value.toString(),
      onChanged: (value) {
        if (value.isNotEmpty) {}
        // return null;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "please enter agent's name";
        }
        return null;
      },
    );
  }

  Widget agentsPhone() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Agent\'s Phone Number',
        hintText: 'Enter Agent\'s Phone Number',
        prefixIcon: const Icon(Icons.phone),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(),
        ),
      ),
      onSaved: (value) => agentPhone = value.toString(),
      onChanged: (value) {
        if (value.isNotEmpty) {}
        // return null;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "please enter agent's phone";
        }
        return null;
      },
    );
  }

  Widget propertysName() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Property\'s Name',
        hintText: 'Enter Property\'s Name',
        prefixIcon: const Icon(Icons.house),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(),
        ),
      ),
      onSaved: (value) => propertyName = value.toString(),
      onChanged: (value) {
        if (value.isNotEmpty) {}
        // return null;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "please enter property's name";
        }
        return null;
      },
    );
  }

  Widget propertysAddress() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Property\'s Address',
        hintText: 'Enter Property\'s Address',
        prefixIcon: const Icon(Icons.home),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(),
        ),
      ),
      onSaved: (value) => propertyAddress = value.toString(),
      onChanged: (value) {
        if (value.isNotEmpty) {}
        // return null;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "please enter your password";
        }
        return null;
      },
    );
  }

  InputDecoration decorate(String label) {
    return InputDecoration(
      prefixIcon: const Icon(Icons.location_pin),
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(),
      ),
    );
  }

  String? validateG(value) {
    if (value.isEmpty) {
      return "field is required, switch on your location";
    }
    return null;
  }

  Future submitData() async {
    setState(() {
      _isLoading = true;
    });
    var res = await http.post(
        Uri.parse('https://kadirs.withholdingtax.ng/mobile/unavailable.php'),
        body: {
          "agname": agentName,
          "agphone": agentPhone,
          "regname": propertyName,
          "busaddress": propertyAddress,
          "long": geolong.text,
          "lat": geolat.text,
        });
    if (res.statusCode == 200) {
      debugPrint(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      if (data["error"]) {
        setState(() {
          //refresh the UI when error is recieved from server
          sending = false;
          error = true;
          msg = data["message"]; //error message from server
        });
      } else {
        setState(() {});

        agentName = '';
        agentPhone = '';

        propertyName = '';
        propertyAddress = '';

        geolong.text = '';
        geolat.text = '';

        showMessage('Data Submitted Succesfully');
        //after write success, make fields empty

        setState(() {
          sending = false;
          success = true; //mark success and refresh UI with setState
        });
      }
    } else {
      //there is error
      setState(() {
        error = true;
        msg = "Error during sending data.";
        sending = false;
        //mark error and refresh UI with setState
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<dynamic> showMessage(String msg) async => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(msg),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
}
