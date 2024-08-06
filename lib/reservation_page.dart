import 'package:flutter/material.dart';
import 'ReservationDao.dart';
import 'ReservationDatabase.dart';
import 'ReservationItem.dart';
import 'add_reservations_page.dart';
import 'reservation_details.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final List<ReservationItem> reservationItems = [];
  late List<String> language = ["Reservation Page", "Switch to French", "Reservation ID", "Customer", "Add Reservation", "Reservation", "Delete Reservation", "Start Blank", "Copy Previous", "Customer's ID", "Please enter a customer's ID", "Customer's Name", "Please enter a customer's name", "Customer's Phone", "Please enter a customer's phone", "Flight ID", "Please enter the flight's ID", "Departure City", "Please enter the departure city", "Destination City", "Please enter the destination city", "Flight Departure Date", "Please enter the flight's departure date", "Arrival Date", "Please enter the flight's arrival date", "Reservation Date", "Please enter the reservation's date", "Save Reservation", "Delete Reservation", "Are you sure you want to delete this reservation?", "Cancel", "Delete", "Reservation registered successfully", "Reservation removed successfully"];
  late ReservationDao dao;
  late bool languageSwitch = true;

  @override
  void initState() {
    super.initState();

    $FloorReservationDatabase.databaseBuilder('ReservationDatabaseFile.db').build().then((database) {
      dao = database.getDao;

      dao.getAllReservations().then((listOfAllItems) {
        setState(() {
          reservationItems.addAll(listOfAllItems);
        });
      });
    });
  }

  void addReservation(ReservationItem reservation) {
    dao.insertReservation(reservation).then((_) {
      setState(() {
        reservationItems.add(reservation);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(language[32]),
        ),
      );
    });
  }

  void deleteReservation(int index) {
    ReservationItem reservation = reservationItems[index];
    dao.deleteReservation(reservation).then((_) {
      setState(() {
        reservationItems.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(language[33]),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language[0]),
        actions: [
          Tooltip(
            message: language[1],
            child: IconButton(
              icon: const Icon(Icons.language),
              onPressed: () {
                setState(() {
                  if(languageSwitch == true) {
                    languageSwitch = false;
                    language = ["Page de Réservation", "Change en Anglais", "ID de Réservation", "Client", "Ajouter une Réservation", "Réservation", "Supprimer la Réservation", "Effacer L’entrée", "Copier Précédent", "ID du Client", "Veuillez saisir l’ID du client", "Nom du Client", "Veuillez entrer le nom du client", "Telephone du Client", "Veuillez entrer le téléphone du client", "ID du vol", "Veuillez entrer l’ID du vol", "Ville de Depart", "Veuillez entrer la ville de départ", "Ville de Destination", "Veuillez entrer la ville de destination", "Date de départ du vol", "Veuillez entrer la date de départ du vol", "Date D’arrivée", "Veuillez entrer la date d’arrivée du vol", "Date de Réservation", "Veuillez entrer la date de la réservation", "Enregistrer la réservation", "Supprimer la Réservation", "Êtes-vous sûre de vouloir supprimer cette réservation?", "Annuler", "Supprimer", "Réservation enregistrée avec succès", "Réservation supprimée avec succès"];
                  } else {
                    languageSwitch = true;
                    language = ["Reservation Page", "Switch to French", "Reservation ID", "Customer", "Add Reservation", "Reservation", "Delete Reservation", "Start Blank", "Copy Previous", "Customer's ID", "Please enter a customer's ID", "Customer's Name", "Please enter a customer's name", "Customer's Phone", "Please enter a customer's phone", "Flight ID", "Please enter the flight's ID", "Departure City", "Please enter the departure city", "Destination City", "Please enter the destination city", "Flight Departure Date", "Please enter the flight's departure date", "Arrival Date", "Please enter the flight's arrival date", "Reservation Date", "Please enter the reservation's date", "Save Reservation", "Delete Reservation", "Are you sure you want to delete this reservation?", "Cancel", "Delete", "Reservation registered successfully", "Reservation removed successfully"];
                  }
                });
              },
            ),
          ),
          const SizedBox(width: 16), // Optional: Adds some spacing
        ],
      ),
      body: ListView.builder(
        itemCount: reservationItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${language[2]}: ${reservationItems[index].id}, ${language[3]}: ${reservationItems[index].customerName}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReservationDetails(
                    reservationItem: reservationItems[index],
                    onDelete: () => deleteReservation(index),
                    language: language,
                    languageSwitch: languageSwitch,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddReservationPage(
                onAddReservation: (reservation) {
                  addReservation(reservation);
                },
                  language: language,
                  languageSwitch: languageSwitch,
              ),
            ),
          );
        },
        tooltip: language[4],
        child: const Icon(Icons.add_box),
      ),
    );
  }
}
