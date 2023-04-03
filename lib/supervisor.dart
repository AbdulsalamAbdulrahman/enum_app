import 'package:flutter/material.dart';

class Supervisor extends StatefulWidget {
  const Supervisor({super.key});

  @override
  State<Supervisor> createState() => _SupervisorState();
}

class _SupervisorState extends State<Supervisor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supervisor Page'),
      ),
      body: const Center(
        child: Text('Under Construction'),
      ),
    );
  }
}
