import 'package:enum_app/homepage.dart';
import 'package:enum_app/profile.dart';
import 'package:enum_app/supervisor.dart';
import 'package:enum_app/search.dart';
import 'package:enum_app/splash_page.dart';
import 'package:enum_app/unavailable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

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
  final String userRole;

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
    required this.userRole,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedScreenIndex = 0;
  List<Widget> _screensEnumerator() => [
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
          userRole: widget.userRole,
        ),
        Search(
          id: widget.id,
          firstname: widget.firstname,
          lastname: widget.lastname,
          team: widget.team,
          ephone: widget.ephone,
          userRole: widget.userRole,
        ),
        Profile(
          id: widget.id,
          firstname: widget.firstname,
          lastname: widget.lastname,
          team: widget.team,
          ephone: widget.ephone,
        ),
        const Unavailable()
      ];

  List<Widget> _screensSupervisor() => [
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
          userRole: widget.userRole,
        ),
        Search(
          id: widget.id,
          firstname: widget.firstname,
          lastname: widget.lastname,
          team: widget.team,
          ephone: widget.ephone,
          userRole: widget.userRole,
        ),
        Profile(
          id: widget.id,
          firstname: widget.firstname,
          lastname: widget.lastname,
          team: widget.team,
          ephone: widget.ephone,
        ),
        const Unavailable(),
        const Supervisor()
      ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = widget.userRole == "supervisor"
        ? _screensSupervisor()
        : _screensEnumerator();
    return Scaffold(
        body: screens[_selectedScreenIndex],
        bottomNavigationBar:
            widget.userRole == "supervisor" ? convexS() : convexE());
  }

  Widget convexS() => ConvexAppBar(
        style: TabStyle.textIn,
        initialActiveIndex: _selectedScreenIndex,
        onTap: _selectScreen,
        height: 40.0,
        backgroundColor: Colors.green.shade900,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.search, title: 'Search'),
          TabItem(icon: Icons.person, title: 'Profile'),
          TabItem(icon: Icons.cancel, title: 'Unavailable'),
          TabItem(icon: Icons.supervised_user_circle, title: 'Supervisor'),
        ],
      );

  Widget convexE() => ConvexAppBar(
        style: TabStyle.textIn,
        initialActiveIndex: _selectedScreenIndex,
        onTap: _selectScreen,
        height: 40.0,
        backgroundColor: Colors.green.shade900,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.search, title: 'Search'),
          TabItem(icon: Icons.person, title: 'Profile'),
          TabItem(icon: Icons.cancel, title: 'Unavailable'),
        ],
      );
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
