import 'package:flutter/material.dart';
import 'airplane.dart'; // Ensure you have the Airplane class

class AirlineListPage extends StatefulWidget {
  @override
  _AirlineListPageState createState() => _AirlineListPageState();
}

class _AirlineListPageState extends State<AirlineListPage> {
  List<Airplane> airlines = [
    Airplane(id: '1', type: 'Airbus A350', passengers: 300, maxSpeed: 900, range: 15000),
    Airplane(id: '2', type: 'Boeing 777', passengers: 400, maxSpeed: 920, range: 16000),
    Airplane(id: '3', type: 'Airbus A320', passengers: 200, maxSpeed: 840, range: 6000),
    Airplane(id: '4', type: 'Boeing 737', passengers: 150, maxSpeed: 850, range: 5500),
    Airplane(id: '5', type: 'Bombardier CRJ-900', passengers: 90, maxSpeed: 830, range: 3000),
    Airplane(id: '6', type: 'Embraer E190', passengers: 100, maxSpeed: 810, range: 4000),
    Airplane(id: '7', type: 'Airbus A330', passengers: 250, maxSpeed: 870, range: 12000),
    Airplane(id: '8', type: 'Boeing 787 Dreamliner', passengers: 290, maxSpeed: 900, range: 15000),
    Airplane(id: '9', type: 'Airbus A310', passengers: 220, maxSpeed: 850, range: 8000),
    Airplane(id: '10', type: 'Boeing 767', passengers: 250, maxSpeed: 880, range: 11000),
  ];

  int _getSoldAirplanesCount() {
    // Implement your logic to determine the count of sold airplanes
    // For now, we will return a static count
    return 2; // Example count
  }

  int _getEmptyAirplanesCount() {
    // Implement your logic to determine the count of empty airplanes
    // For now, we will return a static count
    return airlines.length - _getSoldAirplanesCount();
  }

  void _showAddAirplaneDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Airplane'),
          content: Text('You can add new airplanes here.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airline List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddAirplaneDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Sold Airplanes'),
            subtitle: Text('Count: ${_getSoldAirplanesCount()}'),
          ),
          ListTile(
            title: Text('Empty Airplanes'),
            subtitle: Text('Count: ${_getEmptyAirplanesCount()}'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: airlines.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(airlines[index].type),
                  subtitle: Text('Passengers: ${airlines[index].passengers}'),
                  onTap: () {
                    // Handle tap to view details or perform other actions
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
