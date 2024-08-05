import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'CustomerListPage.dart';
import 'localization_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en', 'US');

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      supportedLocales: [Locale('en', 'US'), Locale('es', 'ES')],
      localizationsDelegates: [
        LocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: MainPage(changeLanguage: _changeLanguage, locale: _locale),
    );
  }
}

class MainPage extends StatelessWidget {
  final Function(Locale) changeLanguage;
  final Locale locale;

  MainPage({required this.changeLanguage, required this.locale});

  @override
  Widget build(BuildContext context) {
    final localization = LocalizationService.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.translate('mainPageTitle')),
        actions: [
          PopupMenuButton<Locale>(
            onSelected: (locale) {
              changeLanguage(locale);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: Locale('en', 'US'),
                child: Text(localization.translate('english')),
              ),
              PopupMenuItem(
                value: Locale('es', 'ES'),
                child: Text(localization.translate('spanish')),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(localization.translate('instructions')),
                  content: Text(localization.translate('instructions_content')),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomerListPage(
                      changeLanguage: changeLanguage,
                      locale: locale,
                    ),
                  ),
                );
              },
              child: Text(localization.translate('customerListPageButton')),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement your logic for other buttons if needed
              },
              child: Text('Other Button'),
            ),
          ],
        ),
      ),
    );
  }
}