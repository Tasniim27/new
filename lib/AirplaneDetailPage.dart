import 'package:flutter/material.dart';
import 'airplane.dart';
import 'AirplaneFormPage.dart';
import 'LocalizationService.dart'; // Import your localization service

class AirplaneDetailPage extends StatelessWidget {
  final Airplane airplane;
  final Function updateAirplane;
  final Function deleteAirplane;

  AirplaneDetailPage({required this.airplane, required this.updateAirplane, required this.deleteAirplane});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(airplane.type),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              _showHelpDialog(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${LocalizationService.translate('airplaneType') ?? 'Type'}: ${airplane.type}', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 10),
            Text('${LocalizationService.translate('passengers') ?? 'Passengers'}: ${airplane.passengers}', style: Theme.of(context).textTheme.bodyText1),
            SizedBox(height: 10),
            Text('${LocalizationService.translate('maxSpeed') ?? 'Max Speed'}: ${airplane.maxSpeed} km/h', style: Theme.of(context).textTheme.bodyText1),
            SizedBox(height: 10),
            Text('${LocalizationService.translate('range') ?? 'Range'}: ${airplane.range} km', style: Theme.of(context).textTheme.bodyText1),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AirplaneFormPage(
                          addOrUpdateAirplane: (updatedAirplane) {
                            updateAirplane(updatedAirplane);
                            Navigator.of(context).pop();
                          },
                          airplane: airplane,
                        ),
                      ),
                    );
                  },
                  child: Text(LocalizationService.translate('update') ?? 'Update'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _confirmDelete(context);
                  },
                  child: Text(LocalizationService.translate('delete') ?? 'Delete'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(LocalizationService.translate('help') ?? 'Help'),
          content: Text(LocalizationService.translate('helpContent') ?? 'Instructions for using the Airplane Detail Page...'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(LocalizationService.translate('close') ?? 'Close'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(LocalizationService.translate('confirmDelete') ?? 'Confirm Delete'),
          content: Text(LocalizationService.translate('confirmDeleteContent') ?? 'Are you sure you want to delete this airplane?'),
          actions: [
            TextButton(
              onPressed: () {
                deleteAirplane(airplane.id);
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Return to the previous screen
              },
              child: Text(LocalizationService.translate('delete') ?? 'Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(LocalizationService.translate('cancel') ?? 'Cancel'),
            ),
          ],
        );
      },
    );
  }
}
