import 'package:flutter/material.dart';

class Revisit extends StatefulWidget {
  const Revisit({super.key});

  @override
  State<Revisit> createState() => _RevisitState();
}

class _RevisitState extends State<Revisit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Revisit Page'),
      ),
      body: const Center(
        child: Text('Under Construction'),
      ),
    );
  }
}
