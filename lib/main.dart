import 'package:enum_app/homepage.dart';
// import 'package:enum_app/login.dart';
import 'package:enum_app/search.dart';
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": const HomePage(), "title": "Home Page"},
    {"screen": const Search(), "title": "Search Agent"}
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedScreenIndex]["title"]),
      ),
      body: _screens[_selectedScreenIndex]["screen"],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        onTap: _selectScreen,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HomePage'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), label: "Search Agent")
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
