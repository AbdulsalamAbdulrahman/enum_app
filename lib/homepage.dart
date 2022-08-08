import 'dart:convert';
import 'dart:async';
import 'package:enum_app/forms.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;

  final List<GlobalKey<FormState>> _formKey = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  void clearf() {
    final floorNo = TextEditingController();
    final shopsperfloor = TextEditingController();
    final rate = TextEditingController();

    final floorNoField = _generateTextField(floorNo, "Floor");
    final shopsperfloorField =
        _generateTextField(shopsperfloor, "Shops On Floor");
    final rateField = _generateTextField(rate, "Rate");

    setState(() {
      floorNoControllers.remove(floorNo);
      shopsperfloorControllers.remove(shopsperfloor);
      rateControllers.remove(rate);
      floorNoFields.remove(floorNoField);
      shopsperfloorFields.remove(shopsperfloorField);
      rateFields.remove(rateField);
    });
  }

  int activeStepIndex = 0;

  String rentType = 'Select Type of Rent';
  String dropdownValue = 'Business Type';
  String dropdownPlaza = 'No. of Floors';
  String dropdownHouses = 'House Type';
  String identification = 'Select Means of Identification';
  String agidentification = 'Select Means of Identification';

  late bool error, sending, success;
  late String msg;

  String phpurl = 'https://kadirs.withholdingtax.ng/write_mobile.php';
  String phpurl2 = 'https://kadirs.withholdingtax.ng/write_mobile_house.php';

//geo
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  // @override
  // void dispose() {
  //   for (final controller in floorNoControllers) {
  //     controller.clear();
  //   }
  //   for (final controller in shopsperfloorControllers) {
  //     controller.clear();
  //   }
  //   for (final controller in rateControllers) {
  //     controller.clear();
  //   }
  //   super.dispose();
  // }

  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    msg = "";
    checkGps();
    super.initState();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          debugPrint("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });
      }
    } else {
      debugPrint("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
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
  }

  Future sendData() async {
    var res = await http.post(Uri.parse(phpurl), body: {
      // jsonEncode(dataa)
      //tp table
      "fullname": fullName.text,
      "regname": regName.text,
      "nationality": nationality.text,
      "resaddress": resAddress.text,
      "phone": phone.text,
      "businesstype": dropdownValue,
      "busname": busName.text,
      "busaddress": busAddress.text,
      "duedate": dueDate.text,
      "busregno": busRegNo.text,
      "tpmeans": identification,
      "tpnin": nin.text,
      "kadirsid": kadIRSId.text,
      "areaoffice": areaoffice.text,
      "renttype": rentType,
      "agname": agName.text,
      "agaddress": agAddress.text,
      "agphone": agPhone.text,
      "agmeans": agidentification,
      "agnin": agNin.text,
      //plaza table
      "nooffloors": dropdownPlaza,
      "totalshops": totalshops.text,

      for (var i = 0; i < floorNoControllers.length; i++)
        "floorno[]": (floorNoControllers[i].text),
      for (var j = 0; j < shopsperfloorControllers.length; j++)
        "shopsperfloor[]": (shopsperfloorControllers[j].text),
      for (var i = 0; i < rateControllers.length; i++)
        "rate[]": (rateControllers[i].text),
    }); //sending post request with header data

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
        fullName.text = '';
        regName.text = '';
        nationality.text = '';
        resAddress.text = '';
        phone.text = '';
        dropdownValue = 'Business Type';
        busName.text = '';
        busAddress.text = '';
        dueDate.text = '';
        busRegNo.text = '';
        areaoffice.text = '';
        identification = "Select Means of Identification";
        nin.text = '';
        kadIRSId.text = '';
        rentType = 'Select Type of Rent';

        agName.text = '';
        agAddress.text = '';
        agPhone.text = '';
        agidentification = 'Select Means of Identification';
        agNin.text = '';

        dropdownPlaza = 'No. of Floors';
        totalshops.text = '';

        floorNoFields.remove(_listView());
        shopsperfloorFields.remove(_listView());
        rateFields.remove(_listView());

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
  }

  Future sendDataHouses() async {
    var res = await http.post(Uri.parse(phpurl2), body: {
      "fullname": fullName.text,
      "regname": regName.text,
      "nationality": nationality.text,
      "resaddress": resAddress.text,
      "phone": phone.text,
      "businesstype": dropdownValue,
      "busname": busName.text,
      "busaddress": busAddress.text,
      "duedate": dueDate.text,
      "busregno": busRegNo.text,
      "tpmeans": identification,
      "tpnin": nin.text,
      "kadirsid": kadIRSId.text,
      "areaoffice": areaoffice.text,
      "renttype": rentType,
      "agname": agName.text,
      "agaddress": agAddress.text,
      "agphone": agPhone.text,
      "agmeans": agidentification,
      "agnin": agNin.text,
      //plaza table
      "housetype": dropdownHouses,
      "flats": flats.text,
      "rateH": rateH.text,
    }); //sending post request with header data

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
        fullName.text = '';
        regName.text = '';
        nationality.text = '';
        resAddress.text = '';
        phone.text = '';
        dropdownValue = 'Business Type';
        busName.text = '';
        busAddress.text = '';
        dueDate.text = '';
        busRegNo.text = '';
        areaoffice.text = '';
        identification = "Select Means of Identification";
        nin.text = '';
        kadIRSId.text = '';
        rentType = 'Select Type of Rent';

        agName.text = '';
        agAddress.text = '';
        agPhone.text = '';
        agidentification = 'Select Means of Identification';
        agNin.text = '';

        dropdownHouses = 'House Type';
        flats.text = '';
        rateH.text = '';

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
  }

  List<Step> stepList() => [
        Step(
          state: activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: activeStepIndex >= 0,
          title: const Text('Landlord'),
          content: Column(
            children: [_form()],
          ),
        ),
        Step(
          state: activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: activeStepIndex >= 1,
          title: const Text('Rent Type'),
          content: (rentType == "Plazas")
              ? _form2()
              : (rentType == "Houses")
                  ? _form3()
                  //     : (rentType == "EventCenter")
                  //         ? _formRent()
                  //         : (rentType == "Schools")
                  //             ? _formRent()
                  //             : (rentType == "Hospitals")
                  //                 ? _formRent()
                  : Container(),
        ),
        Step(
            state:
                activeStepIndex <= 2 ? StepState.editing : StepState.complete,
            isActive: activeStepIndex >= 2,
            title: const Text('Agent'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_form1()],
            )),
        Step(
            state: StepState.complete,
            isActive: activeStepIndex >= 3,
            title: const Text('Confirm'),
            content: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment,
                children: [
                  const Text('LandLord Info',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Taxpayer Name: ${fullName.text}'),
                  Text('Registered Name: ${regName.text}'),
                  Text('Nationality: ${nationality.text}'),
                  Text('Residential Address: ${resAddress.text}'),
                  Text('Phone Number: ${phone.text}'),
                  Text('Business Type: $dropdownValue'),
                  Text('Business Name: ${busName.text}'),
                  Text('Business Address: ${busAddress.text}'),
                  Text('Commencement Date: ${dueDate.text}'),
                  Text('Business Registration No: ${busRegNo.text}'),
                  Text('Taxpayer Identification No(TIN): ${nin.text}'),
                  Text('KadIRS ID: ${kadIRSId.text}'),
                  Text('Rent Type: $rentType'),
                  const Padding(padding: EdgeInsets.all(5.0)),
                  const Text('Agent Info',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Agent\'s Full Name: ${agName.text}'),
                  Text('Agent\'s Phone Number: ${agPhone.text}'),
                  Text('Agent\'s Residential Adress: ${agAddress.text}'),
                  Text('No of floors: $dropdownPlaza'),
                  Text('totalshops: ${totalshops.text}'),
                  for (var i = 0; i < floorNoControllers.length; i++)
                    Text("Floor: ${floorNoControllers[i].text}"),
                  for (var i = 0; i < shopsperfloorControllers.length; i++)
                    Text("Floor: ${shopsperfloorControllers[i].text}"),
                  for (var i = 0; i < rateControllers.length; i++)
                    Text("Floor: ${rateControllers[i].text}"),
                ],
              ),
            )),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: activeStepIndex,
        steps: stepList(),
        onStepContinue: () {
          if (_formKey[activeStepIndex].currentState!.validate()) {
            //   // formKey[activeStepIndex].currentState!.save();
            if (activeStepIndex < (stepList().length - 1)) {
              setState(() {
                activeStepIndex += 1;
              });
            } else {
              // print('Submited');

            }
          }
        },
        onStepCancel: () {
          if (activeStepIndex == 0) {
            return;
          }

          setState(() {
            activeStepIndex -= 1;
          });
        },
        onStepTapped: (int index) {
          setState(() {
            activeStepIndex = index;
          });
        },
        controlsBuilder: (BuildContext context, ControlsDetails controls) {
          final isLastStep = activeStepIndex == stepList().length - 1;
          return Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(500, 60),
                      maximumSize: const Size(500, 60)),
                  // style: ElevatedButton.styleFrom(
                  //     primary: Colors.red, minimumSize: const Size(0, 60)),
                  onPressed: controls.onStepContinue,
                  child: (isLastStep)
                      ? TextButton.icon(
                          icon: _isLoading
                              ? const SizedBox(
                                  height: 15.0,
                                  width: 15.0,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(''),
                          style: TextButton.styleFrom(
                              minimumSize: const Size(500, 60),
                              maximumSize: const Size(500, 60)),
                          onPressed: () {
                            setState(() {
                              sending = true;
                            });
                            rentType == 'Plazas'
                                ? sendData()
                                : rentType == 'Houses'
                                    ? sendDataHouses()
                                    : Container();
                            // debugPrint(floorNoControllers[0].text);
                            // sendData2();
                          },
                          label: const Text('Submit',
                              style: TextStyle(color: Colors.white)),
                        )
                      : const Text('Next'),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              if (activeStepIndex > 0)
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: const Size.fromHeight(60)),
                    onPressed: controls.onStepCancel,
                    child: Text(
                      'Back',
                      style: TextStyle(
                          color: Colors.green.shade900,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
            ],
          );
        },
      ),
    );
  }

  Widget _form() {
    return Form(
      key: _formKey[0],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          textField(fullName, "Taxpayer Name", TextInputType.text),
          const SizedBox(
            height: 20,
          ),
          textField(regName, "Registered Name", TextInputType.text),
          const SizedBox(
            height: 20,
          ),
          textField(nationality, "Nationality", TextInputType.text),
          const SizedBox(
            height: 20,
          ),
          textField(
              resAddress, "Residential Address", TextInputType.streetAddress),
          const SizedBox(
            height: 20,
          ),
          textField(phone, "Phone Number", TextInputType.phone),
          const SizedBox(
            height: 20,
          ),
          dropDown(),
          const SizedBox(
            height: 20,
          ),
          textField(busName, "Business Name", TextInputType.text),
          const SizedBox(
            height: 20,
          ),
          textField(busAddress, "Business Address", TextInputType.text),
          const SizedBox(
            height: 20,
          ),
          datetextField(),
          const SizedBox(
            height: 20,
          ),
          textField(busRegNo, "Business Registered No", TextInputType.text),
          const SizedBox(
            height: 20,
          ),
          // textField(tin, "Taxpayer Identification No", TextInputType.text),
          dropDownID(),
          const SizedBox(
            height: 20,
          ),
          (identification == "TIN")
              ? identiTin()
              : (identification == "NIN")
                  ? identiNin()
                  : Container(),
          const SizedBox(
            height: 20,
          ),
          textField(kadIRSId, "KADIRS ID", TextInputType.text),
          const SizedBox(
            height: 20,
          ),
          textField(areaoffice, "Area Office", TextInputType.text),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: decorate('longitude'),
            controller: geolong,
            enabled: false,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: decorate('latitude'),
            controller: geolat,
            enabled: false,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(60, 60),
              ),
              onPressed: () async {
                getLocation();
                for (var i = 0; i < floorNoControllers.length; i++) {
                  debugPrint(floorNoControllers[i].text);
                }
                for (var j = 0; j < shopsperfloorControllers.length; j++) {
                  debugPrint(shopsperfloorControllers[j].text);
                }
                for (var i = 0; i < rateControllers.length; i++) {
                  debugPrint((rateControllers[i].text));
                }
              },
              child: const Text('Get Geo Location')),
          const SizedBox(
            height: 20,
          ),
          dropDown1(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _form1() {
    return Form(
      key: _formKey[2],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          textField(agName, "Agent's Full Name", TextInputType.text),
          const SizedBox(
            height: 20,
          ),
          textField(agPhone, "Phone number", TextInputType.phone),
          const SizedBox(
            height: 20,
          ),
          textField(agAddress, "Agent's Address", TextInputType.streetAddress),
          const SizedBox(
            height: 20,
          ),
          dropDownAgID(),
          const SizedBox(
            height: 20,
          ),
          (agidentification == "TIN")
              ? agidentiTin()
              : (agidentification == "NIN")
                  ? agidentiNin()
                  : Container(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  // Widget _formRent() {
  //   return Form(
  //     key: formKey[1],
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: const <Widget>[Text("Under Construction")],
  //     ),
  //   );
  // }

  Widget _form2() {
    return Form(
      key: _formKey[1],
      child: Column(
        children: [
          dropDownPlaza(),
          const SizedBox(
            height: 20,
          ),
          textField(totalshops, 'Total No. of Shops', TextInputType.text),
          const SizedBox(
            height: 20,
          ),
          _addTile(),
          _listView(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _form3() {
    return Form(
      key: _formKey[1],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          dropDownHouses(),
          const SizedBox(
            height: 20,
          ),
          (dropdownHouses == "Single")
              ? housesInfo()
              : (dropdownHouses == "1-Bedroom")
                  ? housesInfo()
                  : (dropdownHouses == "2-Bedroom")
                      ? housesInfo()
                      : (dropdownHouses == "3-Bedroom")
                          ? housesInfo()
                          : (dropdownHouses == "4-Bedroom")
                              ? housesInfo()
                              : (dropdownHouses == "5-Bedroom")
                                  ? housesInfo()
                                  : (dropdownHouses == "6-Bedroom")
                                      ? housesInfo()
                                      : (dropdownHouses == "10")
                                          ? housesInfo()
                                          : Container()
        ],
      ),
    );
  }

  Widget datetextField() {
    return TextFormField(
        // validator: validateField,
        controller: dueDate,
        keyboardType: TextInputType.none,
        decoration: decorate('Commencement Date'),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(
                  2000), //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2101));

          if (pickedDate != null) {
            // print(
            //     pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            // print(
            //     formattedDate); //formatted date output using intl package =>  2021-03-16
            //you can implement different kind of Date Format here according to your requirement

            setState(() {
              dueDate.text =
                  formattedDate; //set output date to TextField value.
            });
          } else {}
        });
  }

  Widget dropDown() {
    return DropdownButtonFormField<String>(
        // validator: validateD,

        decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: Colors.grey, width: 0.0),
            ),
            border: OutlineInputBorder()),
        value: dropdownValue,
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>[
          'Business Type',
          'Individual',
          'Group',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          );
        }).toList());
  }

  Widget dropDown1() {
    return DropdownButtonFormField<String>(
      // validator: validateD,
      decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: Colors.grey, width: 0.0),
          ),
          border: OutlineInputBorder()),
      value: rentType,
      onChanged: (String? newValue) {
        setState(() {
          rentType = newValue!;
        });
      },
      items: <String>[
        'Select Type of Rent',
        'Plazas',
        'Houses',
        'Event Center',
        'Schools',
        'Hospitals',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        );
      }).toList(),
    );
  }

  Widget dropDownPlaza() {
    return DropdownButtonFormField<String>(
      // validator: validateD,
      decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: Colors.grey, width: 0.0),
          ),
          border: OutlineInputBorder()),
      value: dropdownPlaza,
      onChanged: (String? newValue) {
        setState(() {
          dropdownPlaza = newValue!;
        });
      },
      items: <String>[
        'No. of Floors',
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        );
      }).toList(),
    );
  }

  Widget dropDownHouses() {
    return DropdownButtonFormField<String>(
      // validator: validateD,
      decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: Colors.grey, width: 0.0),
          ),
          border: OutlineInputBorder()),
      value: dropdownHouses,
      onChanged: (String? newValue) {
        setState(() {
          dropdownHouses = newValue!;
        });
      },
      items: <String>[
        'House Type',
        'Single',
        '1-Bedroom',
        '2-Bedroom',
        '3-Bedroom',
        '4-Bedroom',
        '5-Bedroom',
        '6-Bedroom',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        );
      }).toList(),
    );
  }

  Widget dropDownID() {
    return DropdownButtonFormField<String>(
      // validator: validateD,
      decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: Colors.grey, width: 0.0),
          ),
          border: OutlineInputBorder()),
      value: identification,
      onChanged: (String? newValue) {
        setState(() {
          identification = newValue!;
        });
      },
      items: <String>[
        'Select Means of Identification',
        'TIN',
        'NIN',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        );
      }).toList(),
    );
  }

  Widget dropDownAgID() {
    return DropdownButtonFormField<String>(
      // validator: validateD,
      decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: Colors.grey, width: 0.0),
          ),
          border: OutlineInputBorder()),
      value: agidentification,
      onChanged: (String? newValue) {
        setState(() {
          agidentification = newValue!;
        });
      },
      items: <String>[
        'Select Means of Identification',
        'TIN',
        'NIN',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        );
      }).toList(),
    );
  }

  Future<dynamic> showMessage(String msg) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _addTile() {
    return ListTile(
      title: const Icon(Icons.add),
      onTap: () {
        final floorNo = TextEditingController();
        final shopsperfloor = TextEditingController();
        final rate = TextEditingController();

        final floorNoField = _generateTextField(floorNo, "Floor");
        final shopsperfloorField =
            _generateTextField(shopsperfloor, "Shops On Floor");
        final rateField = _generateTextField(rate, "Rate");

        setState(() {
          floorNoControllers.add(floorNo);
          shopsperfloorControllers.add(shopsperfloor);
          rateControllers.add(rate);
          floorNoFields.add(floorNoField);
          shopsperfloorFields.add(shopsperfloorField);
          rateFields.add(rateField);
        });
      },
    );
  }

  TextField _generateTextField(TextEditingController controller, String hint) {
    return TextField(controller: controller, decoration: decorate(hint));
  }

  Widget _listView() {
    final children = [
      for (var i = 0; i < floorNoControllers.length; i++)
        Container(
          margin: const EdgeInsets.all(15),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: "Add Decription${i + 1}".toString(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Column(
              children: [
                floorNoFields[i],
                const SizedBox(
                  height: 20,
                ),
                shopsperfloorFields[i],
                const SizedBox(
                  height: 20,
                ),
                rateFields[i],
              ],
            ),
          ),
        ),
    ];
    return SingleChildScrollView(
      child: Column(
        children: children,
      ),
    );
  }
}
