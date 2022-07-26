import 'dart:convert';
import 'package:enum_app/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required String title}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final key = GlobalKey<FormState>();

  bool _isObscure = true;

  bool _isLoading = false;

  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.green.shade900,
          Colors.green.shade800,
          Colors.green.shade400
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 80,
              child: Image.asset('kad.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    "Enumeration App",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 60,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Form(
                              key: key,
                              child: Column(
                                children: <Widget>[
                                  user(),
                                  const Padding(padding: EdgeInsets.all(10.0)),
                                  pass()
                                ],
                              ),
                            )),
                        const SizedBox(
                          height: 40,
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
                            _isLoading ? '' : 'Sign in',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(500, 50),
                            maximumSize: const Size(500, 50),
                          ),
                          onPressed: () {
                            if (key.currentState!.validate()) {
                              key.currentState!.save();
                              _isLoading ? null : userLogin();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget user() {
    return Material(
      child: TextFormField(
        keyboardType: TextInputType.text,
        onSaved: (value) => username = value.toString(),
        onChanged: (value) {
          if (value.isNotEmpty) {}
          // return null;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "please enter your username";
          }
          return null;
        },
        decoration: decorate("Username", Icons.person, 'Enter your username'),
      ),
    );
  }

  Widget pass() {
    return TextFormField(
      keyboardType: TextInputType.text,
      obscureText: _isObscure,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        prefixIcon: const Icon(Icons.lock),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isObscure ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ),
      ),
      onSaved: (value) => password = value.toString(),
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

  Future userLogin() async {
    setState(() {
      _isLoading = true;
    });

    Uri url = Uri.parse('https://kadunaelectric.com/meterreading/test.php');

    var data = {'username': username, 'password': password};

    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('username', username);

    var response = await http.post(url, body: json.encode(data));
    if (response.statusCode == 200) {
      //Server response into variable
      // debugPrint(response.body);
      var msg = jsonDecode(response.body);

      //Check Login Status
      if (msg['loginStatus'] == true) {
        setState(() {
          //hide progress indicator
          _isLoading = false;
        });
        if (!mounted) return;

        // Navigate to Home Screen
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
      } else {
        setState(() {
          //hide progress indicator
          _isLoading = false;

          //Show Error Message Dialog
          showMessage(msg["message"]);
        });
      }
    } else {
      setState(() {
        //hide progress indicator
        _isLoading = false;

        //Show Error Message Dialog
        showMessage("Error connecting to Server.");
      });
    }
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

InputDecoration decorate(String label, icon, String hint) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    prefixIcon: Icon(icon),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(),
    ),
  );
}
