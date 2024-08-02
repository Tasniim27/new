import 'package:flutter/material.dart';
import 'main_page.dart'; // Import the main page
import 'customer_list_page.dart'; // Import other pages
import 'airplane_list_page.dart';
import 'flights_list_page.dart';
import 'reservation_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
      routes: {
        '/customerList': (context) => CustomerListPage(),
        '/airplaneList': (context) => AirplaneListPage(),
        '/flightsList': (context) => FlightsListPage(),
        '/reservation': (context) => ReservationPage(),
      },
    );
  }
}
