import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project/reservation_page.dart';
import 'LocalizationService.dart';
import 'AirplaneListPage.dart'; // Ensure you import the AirplaneListPage
import 'AirplaneFormPage.dart'; // Ensure you import the AirplaneFormPage
import 'AirlineListPage.dart';
import 'customer_list_page.dart';
import 'flights_list_page.dart'; // Ensure you import the AirlineListPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeLanguage(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en', 'US'); // Default locale

  @override
  void initState() {
    super.initState();
    LocalizationService.load(_locale); // Load the default locale
  }

  void changeLanguage(Locale newLocale) {
    setState(() {
      _locale = newLocale;
      LocalizationService.load(newLocale); // Load new locale
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airplane Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      locale: _locale,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'ES'),
        // Add more supported locales here
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: MainPage(),
      routes: {
        '/airlineList': (context) => AirlineListPage(),
        '/addAirplane': (context) => AirplaneFormPage(
          addOrUpdateAirplane: (airplane) {
            // Handle the addition of a new airplane here if needed
          },
        ),
        '/manageAirplanes': (context) => AirplaneListPage(),
        '/customerList': (context) => CustomerListPage(), // Assuming you have a CustomerListPage
        '/flightsList': (context) => FlightsListPage(), // Assuming you have a FlightsListPage
        '/reservation': (context) => ReservationPage(), // Assuming you have a ReservationPage
      },
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationService.translate('mainMenuTitle') ?? 'Main Menu'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => _showInstructionsDialog(context),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/airplane.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Main Menu Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocalizationService.translate('welcomeMessage') ?? 'Welcome to the Airline Management System!',
                  style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white),
                ),

                SizedBox(height: 10),
                _buildNavigationButton(context, LocalizationService.translate('manageAirplanes') ?? 'Manage Airplanes', '/manageAirplanes'),
                SizedBox(height: 10),
                _buildNavigationButton(context, LocalizationService.translate('customerList') ?? 'Customer List', '/customerList'),
                SizedBox(height: 10),
                _buildNavigationButton(context, LocalizationService.translate('flightsList') ?? 'Flights List', '/flightsList'),
                SizedBox(height: 10),
                _buildNavigationButton(context, LocalizationService.translate('reservation') ?? 'Reservation', '/reservation'),
                SizedBox(height: 10),
                _buildNavigationButton(context, LocalizationService.translate('changeLanguage') ?? 'Change Language', ''),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context, String text, String route) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        textStyle: TextStyle(fontSize: 18),
      ),
      child: Text(text),
      onPressed: () {
        if (route.isNotEmpty) {
          Navigator.of(context).pushNamed(route);
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(LocalizationService.translate('selectLanguage') ?? 'Select Language'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('English'),
                    onTap: () {
                      Navigator.of(context).pop();
                      MyApp.setLocale(context, Locale('en', 'US'));
                    },
                  ),
                  ListTile(
                    title: Text('Spanish'),
                    onTap: () {
                      Navigator.of(context).pop();
                      MyApp.setLocale(context, Locale('es', 'ES'));
                    },
                  ),
                  // Add more languages here
                ],
              ),
            ),
          );
        }
      },
    );
  }

  void _showInstructionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Instructions'),
          content: Text('Use the buttons to navigate to different sections of the application.'),
          actions: [
            TextButton(
              child: Text('OK'),
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
