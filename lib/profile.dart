import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  final String id;
  final String firstname;
  final String lastname;
  final String team;
  final String ephone;

  const Profile(
      {super.key,
      required this.id,
      required this.firstname,
      required this.lastname,
      required this.team,
      required this.ephone});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String daily = '';
  String monthly = '';
  String total = '';

  @override
  void initState() {
    counter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 44),
            const CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.person,
                size: 60,
              ),
            ),
            buildName(),
            const SizedBox(height: 44),
            Wrap(
              runAlignment: WrapAlignment.center,
              direction: Axis.vertical,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildButton(context, daily, 'Daily Submission'),
                    buildDivider(),
                    buildButton(context, monthly, 'Monthly Submission'),
                    buildDivider(),
                    buildButton(context, total, 'Total'),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildDivider() => const SizedBox(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(
                  color: Color.fromARGB(255, 27, 94, 32),
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(
                  color: Color.fromARGB(255, 27, 94, 32),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );

  Widget buildName() => Column(
        children: [
          Text(
            '${widget.firstname} ${widget.lastname}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            widget.team,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            widget.ephone,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  Future counter() async {
    Uri url =
        Uri.parse('https://withholdingtax.ng/kadirs/mobile/daily_sub.php');

    var data = {
      'id': widget.id,
    };

    var response = await http.post(
      url,
      body: json.encode(data),
    );
    var jsondata = json.decode(response.body);

    if (response.statusCode == 200) {
      int dailyJson = jsondata["Daily"];
      int monthlyJson = jsondata["Monthly"];
      int totalJson = jsondata["Total"];

      setState(() {
        daily = dailyJson.toString();
        monthly = monthlyJson.toString();
        total = totalJson.toString();
      });
    }
  }
}
