import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => _showInstructionsDialog(context),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildNavigationButton(context, 'Customer List', '/customerList'),
            _buildNavigationButton(context, 'Airplane List', '/airplaneList'),
            _buildNavigationButton(context, 'Flights List', '/flightsList'),
            _buildNavigationButton(context, 'Reservation', '/reservation'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context, String text, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Text(text),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          textStyle: TextStyle(fontSize: 18),
        ),
      ),
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
