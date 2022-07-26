import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  int _activeStepIndex = 0;

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

  String rentType = 'Select Type of Rent';
  String dropdownValue = 'Business Type';

  late bool error, sending, success;
  late String msg;

  String phpurl = 'https://kadunaelectric.com/meterreading/test_write.php';

  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    msg = "";
    super.initState();
  }

  Future<void> sendData() async {
    var res = await http.post(Uri.parse(phpurl), body: {
      "fullname": fullName.text,
      "regname": regName.text,
      "nationality": nationality.text,
      "resaddress": resAddress.text,
      "phone": phone.text,
      "Businesstype": dropdownValue,
      "busname": busName.text,
      "busaddress": busAddress.text,
      "duedate": dueDate.text,
      "busregno": busRegNo.text,
      "tin": tin.text,
      "kadirsid": kadIRSId.text,
      "renttype": rentType,
      "agname": agName.text,
      "agaddress": agAddress.text,
      "agphone": agPhone.text
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
        fullName.text = "";
        phone.text = "";
        dueDate.text = "";
        dropdownValue = 'Business Type';

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
        msg = "Error during sendign data.";
        sending = false;
        //mark error and refresh UI with setState
      });
    }
  }

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Landlord'),
          content: Column(
            children: [_form()],
          ),
        ),
        Step(
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const Text('Rent Type'),
          content: (rentType == "Plazas")
              ? _formRent()
              : (rentType == "Houses")
                  ? _formRent()
                  : (rentType == "EventCenter")
                      ? _formRent()
                      : (rentType == "Schools")
                          ? _formRent()
                          : (rentType == "Hospitals")
                              ? _formRent()
                              : _formRent(),
        ),
        Step(
            state:
                _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('Agent'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_form1()],
            )),
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 3,
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
                  Text('Taxpayer Identification No(TIN): ${tin.text}'),
                  Text('KadIRS ID: ${kadIRSId.text}'),
                  Text('Rent Type: $rentType'),
                  const Padding(padding: EdgeInsets.all(5.0)),
                  const Text('Agent Info',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Agent\'s Full Name: ${agName.text}'),
                  Text('Agent\'s Phone Number: ${agPhone.text}'),
                  Text('Agent\'s Residential Adress: ${agAddress.text}'),
                ],
              ),
            )),
      ];

  // File? image;
  // File? _image;

  // Future pickImage() async {
  //   final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     setState(() {
  //       _image = File(basename(image.path));
  //     });
  //   }
  //   // debugPrint(basename(_image));
  // }

  // void _pickFile() async {
  // opens storage to pick files and the picked file or files
  // are assigned into result and if no file is chosen result is null.
  // you can also toggle "allowMultiple" true or false depending on your need
  // FilePickerResult? result =
  //     await FilePicker.platform.pickFiles(allowMultiple: false);

  // if (result != null) {
  //   PlatformFile file = result.files.first;

  //   debugPrint(file.name);
  // }

  // if no file is picked
  // if (result == null) return;

  // String filename = result.files.first.name;
  // // we will log the name, size and path of the
  // // first picked file (if multiple are selected)
  // // print(result.files.first.name);
  // print(file.name);
  // print(result.files.first.size);
  // print(result.files.first.path);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _activeStepIndex,
        steps: stepList(),
        onStepContinue: () {
          if (_activeStepIndex < (stepList().length - 1)) {
            setState(() {
              _activeStepIndex += 1;
            });
          } else {
            // print('Submited');
          }
        },
        onStepCancel: () {
          if (_activeStepIndex == 0) {
            return;
          }

          setState(() {
            _activeStepIndex -= 1;
          });
        },
        onStepTapped: (int index) {
          setState(() {
            _activeStepIndex = index;
          });
        },
        controlsBuilder: (BuildContext context, ControlsDetails controls) {
          final isLastStep = _activeStepIndex == stepList().length - 1;
          return Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(60)),
                  onPressed: controls.onStepContinue,
                  child: (isLastStep)
                      ? TextButton(
                          style: TextButton.styleFrom(
                              minimumSize: const Size.fromHeight(60)),
                          onPressed: () {
                            setState(() {
                              sending = true;
                            });
                            sendData();
                          },
                          child: const Text('Submit',
                              style: TextStyle(color: Colors.white)),
                        )
                      : const Text('Next'),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              if (_activeStepIndex > 0)
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: const Size.fromHeight(60)),
                    onPressed: controls.onStepCancel,
                    child: Text(
                      'Cancel',
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
      key: _formKey,
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
          DropdownButtonFormField<String>(
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
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 20,
          ),
          textField(busName, "Businness Name", TextInputType.text),
          const SizedBox(
            height: 20,
          ),
          textField(
              busAddress, "Businness Address", TextInputType.streetAddress),
          const SizedBox(
            height: 20,
          ),
          // textField(dueDate, "Commencement Date", TextInputType.datetime),
          TextFormField(
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
                  String formattedDate =
                      DateFormat('dd-MM-yyyy').format(pickedDate);
                  // print(
                  //     formattedDate); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement

                  setState(() {
                    dueDate.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {
                  debugPrint("Date is not selected");
                }
              }),
          const SizedBox(
            height: 20,
          ),
          textField(busRegNo, "Businness Registered No", TextInputType.text),
          const SizedBox(
            height: 20,
          ),
          textField(tin, "Taxpayer Identification No", TextInputType.text),
          const SizedBox(
            height: 20,
          ),
          textField(kadIRSId, "KADIRS ID", TextInputType.text),
          const SizedBox(
            height: 20,
          ),
          DropdownButtonFormField<String>(
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
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _form1() {
    return Form(
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
        ],
      ),
    );
  }

  Widget _formRent() {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const <Widget>[Text("Under Construction")],
      ),
    );
  }

  Widget textField(controllerValue, String label, inputType) {
    return TextFormField(
      controller: controllerValue,
      keyboardType: inputType,
      decoration: decorate(label),
    );
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
}
