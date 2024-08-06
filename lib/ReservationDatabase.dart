import 'package:floor/floor.dart';
import 'ReservationDao.dart';
import 'ReservationItem.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'ReservationDatabase.g.dart'; // the generated code will be there
@Database(version: 1, entities: [ReservationItem])
abstract class ReservationDatabase extends FloorDatabase {
  ReservationDao get getDao;
}