import 'package:flutter/material.dart';
import 'ReservationItem.dart';

class ReservationDetails extends StatelessWidget {
  const ReservationDetails({super.key, required this.reservationItem, required this.onDelete, required this.language, required this.languageSwitch});

  final ReservationItem reservationItem;
  final VoidCallback onDelete;
  final List<String> language;
  final bool languageSwitch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language[5]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(languageSwitch ? reservationItem.toStringEn() : reservationItem.toStringFr()),
            const SizedBox(height: 30), // Adjust the height as needed
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(language[28]),
                      content: Text(language[29]),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Dismiss the dialog
                          },
                          child: Text(language[30]),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pop(context);
                            onDelete();
                          },
                          child: Text(language[31]),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(language[6]),
            ),
          ],
        ),
      ),
    );
  }
}
