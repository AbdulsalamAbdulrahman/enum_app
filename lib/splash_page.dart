import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:enum_app/login.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
        'kad.jpg',
        alignment: Alignment.center,
      ),
      logoSize: 100,
      backgroundColor: Colors.white,
      showLoader: true,
      loaderColor: Colors.green.shade900,
      loadingText: const Text(
        "Loading...",
        style: TextStyle(color: Colors.black54),
      ),
      navigator: const Login(
        title: '',
      ),
      durationInSeconds: 3,
    );
  }
}
