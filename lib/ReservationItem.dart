import 'package:floor/floor.dart';

@entity
class ReservationItem {
  static int ID = 1;

  final int customerID; // Id or object
  final String customerName;
  final String customerPhone;
  final int flightID;
  final String departureCity;
  final String destinationCity;
  final String departureTime;
  final String arrivalTime;
  final String reservationDate;

  @primaryKey
  final int id;

  ReservationItem(this.id, this.customerID, this.flightID, this.reservationDate, this.customerName, this.customerPhone, this.departureCity, this.destinationCity, this.departureTime, this.arrivalTime) {
    if(id >= ID) {
      ID = id + 1;
    }
  }

  String toStringEn() {
    return 'id: $id, \ncustomerID: $customerID, \ncustomerName: $customerName, \ncustomerPhone: $customerPhone, \nflightID: $flightID, \ndepartureCity: $departureCity, \ndestinationCity: $destinationCity, \ndepartureTime: $departureTime, \narrivalTime: $arrivalTime, \nreservationDate: $reservationDate';
  }
  String toStringFr() {
    return 'id: $id, \nID du Client: $customerID, \nNom du Client: $customerName, \nTelephone du Client: $customerPhone, \nID du Vol : $flightID, \ndépartVille: $departureCity, \ndestinationVille: $destinationCity, \nHeure de Départ: $departureTime, \nHeure Arrivée: $arrivalTime, \nDate de Réservation: $reservationDate';
  }
}

