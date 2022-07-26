import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  int _activeStepIndex = 0;

  String dropdownValue = 'Business Type';

  TextEditingController fullName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController businessAddress = TextEditingController();
  TextEditingController contactAddress = TextEditingController();
  TextEditingController email = TextEditingController();
  // TextEditingController businessName = TextEditingController();
  TextEditingController kadIRSId = TextEditingController();
  TextEditingController rcNo = TextEditingController();

  TextEditingController ownerFullName = TextEditingController();
  TextEditingController ownerPhoneNumber = TextEditingController();
  TextEditingController ownerAddress = TextEditingController();

  TextEditingController rentAmount = TextEditingController();
  TextEditingController dueDate = TextEditingController();
  TextEditingController doc = TextEditingController();

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
      "phonenumber": phoneNumber.text,
      "baddress": businessAddress.text,
      "caddress": contactAddress.text,
      "email": email.text,
      "kadirsid": kadIRSId.text,
      "rcno": rcNo.text,
      "ofullname": ownerFullName.text,
      "ophone": ownerPhoneNumber.text,
      "oaddress": ownerAddress.text,
      "rentamount": rentAmount.text,
      "duedate": dueDate.text,
      "btype": dropdownValue,
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
        phoneNumber.text = "";
        businessAddress.text = "";
        contactAddress.text = "";
        email.text = "";
        kadIRSId.text = "";
        rcNo.text = "";
        ownerFullName.text = "";
        ownerPhoneNumber.text = "";
        ownerAddress.text = "";
        rentAmount.text = "";
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
          title: const Text('Tenant'),
          content: Column(
            children: [_form()],
          ),
        ),
        Step(
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const Text('Owner'),
          content: (dropdownValue == "Individual")
              ? textField(rentAmount, "Test Amount", "")
              : textField(rentAmount, "Rent Amount", ""),

          // Column(
          //   children: [
          //     textField(
          //         ownerFullName, "Full name", "Enter owner's full name"),
          //     const SizedBox(
          //       height: 20,
          //     ),
          //     textField(ownerAddress, "Residential address",
          //         "Enter owner's address"),
          //     const SizedBox(
          //       height: 20,
          //     ),
          //     textField(ownerPhoneNumber, "Phone number",
          //         "Enter owner's phone number"),
          //     const SizedBox(
          //       height: 20,
          //     ),
          //   ],
          // )
        ),
        Step(
            state:
                _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('Assessment'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textField(rentAmount, "Rent Amount", ""),
                const SizedBox(
                  height: 20,
                ),
                textField(dueDate, "Due Date", ""),
                const SizedBox(
                  height: 20,
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.folder_open),
                  onPressed: () {
                    // pickImage();
                    _pickFile();
                  },
                  label: const Text("Attach Document"),
                  // style: ,
                ),

                // _image != null
                //     ? Text(basename(_image!.name))
                //     : const Text('Please select an image'),
                const SizedBox(
                  height: 20,
                ),
              ],
            )),
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 3,
            title: const Text('Confirm'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Tenant Info',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Full Name: ${fullName.text}'),
                Text('phone Number: ${phoneNumber.text}'),
                Text('Business Address: ${businessAddress.text}'),
                Text('Contact Address: ${contactAddress.text}'),
                Text('Email: ${email.text}'),
                Text('KadIRS ID: ${kadIRSId.text}'),
                Text('RC Number: ${rcNo.text}'),
                Text('Business Type: $dropdownValue'),
                const Text('Owner Info',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Owner\'s Full Name: ${ownerFullName.text}'),
                Text('Owner\'s Phone Number: ${ownerPhoneNumber.text}'),
                Text('Owner\'s Residential Adress: ${ownerAddress.text}'),
                const Text('Assessment',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Rent Amount: ${rentAmount.text}'),
                Text('Due Date: ${dueDate.text}'),
              ],
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

  void _pickFile() async {
    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result != null) {
      PlatformFile file = result.files.first;

      debugPrint(file.name);
    }

    // if no file is picked
    // if (result == null) return;

    // String filename = result.files.first.name;
    // // we will log the name, size and path of the
    // // first picked file (if multiple are selected)
    // // print(result.files.first.name);
    // print(file.name);
    // print(result.files.first.size);
    // print(result.files.first.path);
  }

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
          textField(fullName, "Full name", "Enter tenant's full name"),
          const SizedBox(
            height: 20,
          ),
          textField(phoneNumber, "Phone number", "Enter tenant's phone number"),
          const SizedBox(
            height: 20,
          ),
          textField(contactAddress, "Contact address",
              "Enter tenant's contact address"),
          const SizedBox(
            height: 20,
          ),
          textField(businessAddress, "Businness address",
              "Enter tenant's business address"),
          const SizedBox(
            height: 20,
          ),
          textField(email, "Email", "Enter tenant's email address"),
          const SizedBox(
            height: 20,
          ),
          textField(rcNo, "RC number", "Enter tenant's RC number"),
          const SizedBox(
            height: 20,
          ),
          textField(kadIRSId, "KADIRS ID", "Enter tenant's KADIRS ID"),
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
        ],
      ),
    );
  }

  Widget textField(controller, String label, hint) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: decorate(label, hint),
    );
  }

  InputDecoration decorate(String label, String hint) {
    return InputDecoration(
        labelText: label,
        hintText: hint,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(color: Colors.grey, width: 0.0),
        ),
        border: const OutlineInputBorder());
  }

//  "fullname": fullName.text,
//  "phonenumber": phoneNumber.text,
//  "baddress": businessAddress.text,
//  "caddress": contactAddress.text,
//  "email": email.text,
//  "bname": businessName.text,
//  "kadirsid": kadIRSId.text,
//  "rcno": rcNo.text,
//  "ofullname": ownerFullName.text,
//  "ophone": ownerPhoneNumber.text,
//  "oaddress": ownerAddress.text,
//  "rentamount": rentAmount.text,
//  "duedate": dueDate.text,

// ($_POST["fullname"]) && isset($_POST["phonenumber"])
//          && isset($_POST["baddress"]) && isset($_POST["caddress"])
//          && isset($_POST["email"])&& isset($_POST["bname"])
//          && isset($_POST["kadirsid"])&& isset($_POST["rcno"])
//          && isset($_POST["ofullname"])&& isset($_POST["ophone"])
//          && isset($_POST["oaddress"])&& isset($_POST["rentamount"])
//          && isset($_POST["duedate"])

//  $fullname
// $phonenumber
//    $baddress
//    $caddress
//       $email
//       $bname
//    $kadirsid
//        $rcno
//   $ofullname
//      $ophone
//    $oaddress
//  $rentamount
//     $duedate

// $fullname = mysqli_real_escape_string($link, $fullname);
//             $phonenumber = mysqli_real_escape_string($link, $phonenumber);
//             $baddress = mysqli_real_escape_string($link, $baddress);
//             $caddress = mysqli_real_escape_string($link, $caddress);
//             $email = mysqli_real_escape_string($link, $email);
//             $bname = mysqli_real_escape_string($link, $bname);
//             $kadirsid = mysqli_real_escape_string($link, $kadirsid);
//             $rcno = mysqli_real_escape_string($link, $rcno);
//             $ofullname = mysqli_real_escape_string($link, $ofullname);
//             $ophone = mysqli_real_escape_string($link, $ophone);
//             $oaddress = mysqli_real_escape_string($link, $oaddress);
//             $rentamount = mysqli_real_escape_string($link, $rentamount);
//             $duedate = mysqli_real_escape_string($link, $duedate);

}
