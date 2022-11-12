import 'package:enum_app/homepage.dart';
// import 'package:enum_app/login.dart';
// import 'package:enum_app/login.dart';
import 'package:enum_app/search.dart';
import 'package:enum_app/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:app_settings/app_settings.dart';

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
      home: const SplashPage(
          // mail: '',
          // fname: '',
          // phone: '',
          // role: '',
          // nin: '',
          ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String fname;
  final String phone;
  final String mail;
  final String role;
  final String nin;

  const MyHomePage(
      {Key? key,
      required this.mail,
      required this.fname,
      required this.phone,
      required this.role,
      required this.nin})
      : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // _MyHomePageState(String mail) {
  //   maill = mail;
  //   print('mail:' + maill);
  // }

  // static late String maill = '';
  //geo
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  // late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    checkGps();
    super.initState();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          debugPrint("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });
      }
    } else if (!servicestatus) {
      //open location settings
      return locPop('Switch on Location Service');
    } else {
      debugPrint("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  // // @override
  // // void initState() {
  // //   // maill = widget.mail;
  // //   print('mail:' + maill);
  // //   super.initState();
  // // }

  int _selectedScreenIndex = 0;
  List<Widget> _screens() => [
        HomePage(
          mail: widget.mail,
          fname: widget.fname,
          phone: widget.phone,
          role: widget.role,
          nin: widget.nin,
        ),
        const Search()
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
              icon: Icon(Icons.search), label: "Search Agent")
        ],
      ),
    );
  }

  Future<dynamic> locPop(String msg) async {
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
                AppSettings.openLocationSettings();
              },
            ),
          ],
        );
      },
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
