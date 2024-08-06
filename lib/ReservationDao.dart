import 'package:floor/floor.dart';
import 'ReservationItem.dart';

@dao
abstract class ReservationDao {
  @Query('SELECT * FROM ReservationItem')
  Future<List<ReservationItem>> findAllReservations();

  @insert
  Future<void> insertReservation(ReservationItem reservation);

  @delete
  Future<int> deleteReservation(ReservationItem reservation);

  @Query('Select * from ReservationItem')
  Future< List<ReservationItem> > getAllReservations( );

  @update
  Future<int> updateToReservations(ReservationItem itm);
}
