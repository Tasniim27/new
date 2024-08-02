import 'package:flutter/material.dart';
import 'AirplaneFormPage.dart';
import 'AirplaneDetailPage.dart';
import 'airplane.dart';

class AirplaneListPage extends StatefulWidget {
  @override
  _AirplaneListPageState createState() => _AirplaneListPageState();
}

class _AirplaneListPageState extends State<AirplaneListPage> {
  List<Airplane> airplanes = [
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

  void _addOrUpdateAirplane(Airplane airplane) {
    setState(() {
      int index = airplanes.indexWhere((plane) => plane.id == airplane.id);
      if (index != -1) {
        airplanes[index] = airplane;
      } else {
        airplanes.add(airplane);
      }
    });
  }

  void _deleteAirplane(String id) {
    setState(() {
      airplanes.removeWhere((plane) => plane.id == id);
    });
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Help'),
          content: Text('Instructions for using the Airplane Management System...'),
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
        title: Text('Airplane List'),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: _showHelpDialog,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: airplanes.length,
        itemBuilder: (ctx, index) {
          return ListTile(
            title: Text(airplanes[index].type),
            subtitle: Text('Passengers: ${airplanes[index].passengers}'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AirplaneDetailPage(
                    airplane: airplanes[index],
                    updateAirplane: _addOrUpdateAirplane,
                    deleteAirplane: _deleteAirplane,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AirplaneFormPage(
                addOrUpdateAirplane: _addOrUpdateAirplane,
              ),
            ),
          );
        },
      ),
    );
  }
}
