import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String id;
  const Profile({super.key, required this.id});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
                    buildButton(context, '4', 'Daily Submission'),
                    buildDivider(),
                    buildButton(context, '35', 'Monthly Syubmission'),
                    buildDivider(),
                    buildButton(context, '50', 'Total'),
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
        children: const [
          Text(
            'Abdulsalam Abdulrahman',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(height: 4),
          Text(
            'admin',
            style: TextStyle(color: Colors.grey),
          )
        ],
      );
}
