import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'LocalizationService.dart';
import 'AirplaneListPage.dart'; // Ensure you import the AirplaneListPage
import 'AirplaneFormPage.dart'; // Ensure you import the AirplaneFormPage
import 'AirlineListPage.dart'; // Ensure you import the AirlineListPage

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
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationService.translate('mainMenuTitle') ?? 'Main Menu'),
      ),
      body: Stack(
        fit: StackFit.expand, // Ensures the stack takes up the full screen
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/airplane.jpg',
              fit: BoxFit.cover, // Ensures the image covers the entire container
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
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button color
                  ),
                  child: Text(LocalizationService.translate('viewAirlineList') ?? 'View Airline List'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AirlineListPage(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button color
                  ),
                  child: Text(LocalizationService.translate('addAirplane') ?? 'Add Airplane'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AirplaneFormPage(
                          addOrUpdateAirplane: (airplane) {
                            // Handle the addition of a new airplane here if needed
                          },
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button color
                  ),
                  child: Text(LocalizationService.translate('manageAirplanes') ?? 'Manage Airplanes'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AirplaneListPage(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button color
                  ),
                  child: Text(LocalizationService.translate('changeLanguage') ?? 'Change Language'),
                  onPressed: () {
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
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
