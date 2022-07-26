import 'package:enum_app/homepage.dart';
import 'package:enum_app/profile.dart';
import 'package:enum_app/search.dart';
import 'package:enum_app/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  // add these lines
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tax Enumeration',
        theme: ThemeData(
          primarySwatch: colorCustom,
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const SplashPage());
  }
}

class MyHomePage extends StatefulWidget {
  final String fname;
  final String phone;
  final String mail;
  final String role;
  final String nin;
  final String id;
  final String firstname;
  final String lastname;
  final String team;
  final String ephone;

  const MyHomePage({
    Key? key,
    required this.mail,
    required this.fname,
    required this.phone,
    required this.role,
    required this.nin,
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.team,
    required this.ephone,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedScreenIndex = 0;
  List<Widget> _screens() => [
        HomePage(
          mail: widget.mail,
          fname: widget.fname,
          phone: widget.phone,
          role: widget.role,
          nin: widget.nin,
          id: widget.id,
          firstname: widget.firstname,
          lastname: widget.lastname,
          team: widget.team,
          ephone: widget.ephone,
        ),
        Search(
          id: widget.id,
          firstname: widget.firstname,
          lastname: widget.lastname,
          team: widget.team,
          ephone: widget.ephone,
        ),
        Profile(
          id: widget.id,
          firstname: widget.firstname,
          lastname: widget.lastname,
          team: widget.team,
          ephone: widget.ephone,
        ),
      ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = _screens();
    return Scaffold(
      body: screens[_selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        onTap: _selectScreen,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HomePage'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), label: "Search Agent"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

MaterialColor colorCustom = const MaterialColor(
  0xFF1B5E20,
  <int, Color>{
    50: Color.fromARGB(255, 27, 94, 32),
    100: Color.fromARGB(255, 27, 94, 32),
    200: Color.fromARGB(255, 27, 94, 32),
    300: Color.fromARGB(255, 27, 94, 32),
    400: Color.fromARGB(255, 27, 94, 32),
    500: Color.fromARGB(255, 27, 94, 32),
    600: Color.fromARGB(255, 27, 94, 32),
    700: Color.fromARGB(255, 27, 94, 32),
    800: Color.fromARGB(255, 27, 94, 32),
    900: Color.fromARGB(255, 27, 94, 32),
  },
);
