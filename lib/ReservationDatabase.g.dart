// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ReservationDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $ReservationDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $ReservationDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $ReservationDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<ReservationDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorReservationDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $ReservationDatabaseBuilderContract databaseBuilder(String name) =>
      _$ReservationDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $ReservationDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$ReservationDatabaseBuilder(null);
}

class _$ReservationDatabaseBuilder
    implements $ReservationDatabaseBuilderContract {
  _$ReservationDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $ReservationDatabaseBuilderContract addMigrations(
      List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $ReservationDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<ReservationDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$ReservationDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ReservationDatabase extends ReservationDatabase {
  _$ReservationDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ReservationDao? _getDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ReservationItem` (`customerID` INTEGER NOT NULL, `customerName` TEXT NOT NULL, `customerPhone` TEXT NOT NULL, `flightID` INTEGER NOT NULL, `departureCity` TEXT NOT NULL, `destinationCity` TEXT NOT NULL, `departureTime` TEXT NOT NULL, `arrivalTime` TEXT NOT NULL, `reservationDate` TEXT NOT NULL, `id` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ReservationDao get getDao {
    return _getDaoInstance ??= _$ReservationDao(database, changeListener);
  }
}

class _$ReservationDao extends ReservationDao {
  _$ReservationDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _reservationItemInsertionAdapter = InsertionAdapter(
            database,
            'ReservationItem',
            (ReservationItem item) => <String, Object?>{
                  'customerID': item.customerID,
                  'customerName': item.customerName,
                  'customerPhone': item.customerPhone,
                  'flightID': item.flightID,
                  'departureCity': item.departureCity,
                  'destinationCity': item.destinationCity,
                  'departureTime': item.departureTime,
                  'arrivalTime': item.arrivalTime,
                  'reservationDate': item.reservationDate,
                  'id': item.id
                }),
        _reservationItemUpdateAdapter = UpdateAdapter(
            database,
            'ReservationItem',
            ['id'],
            (ReservationItem item) => <String, Object?>{
                  'customerID': item.customerID,
                  'customerName': item.customerName,
                  'customerPhone': item.customerPhone,
                  'flightID': item.flightID,
                  'departureCity': item.departureCity,
                  'destinationCity': item.destinationCity,
                  'departureTime': item.departureTime,
                  'arrivalTime': item.arrivalTime,
                  'reservationDate': item.reservationDate,
                  'id': item.id
                }),
        _reservationItemDeletionAdapter = DeletionAdapter(
            database,
            'ReservationItem',
            ['id'],
            (ReservationItem item) => <String, Object?>{
                  'customerID': item.customerID,
                  'customerName': item.customerName,
                  'customerPhone': item.customerPhone,
                  'flightID': item.flightID,
                  'departureCity': item.departureCity,
                  'destinationCity': item.destinationCity,
                  'departureTime': item.departureTime,
                  'arrivalTime': item.arrivalTime,
                  'reservationDate': item.reservationDate,
                  'id': item.id
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ReservationItem> _reservationItemInsertionAdapter;

  final UpdateAdapter<ReservationItem> _reservationItemUpdateAdapter;

  final DeletionAdapter<ReservationItem> _reservationItemDeletionAdapter;

  @override
  Future<List<ReservationItem>> findAllReservations() async {
    return _queryAdapter.queryList('SELECT * FROM ReservationItem',
        mapper: (Map<String, Object?> row) => ReservationItem(
            row['id'] as int,
            row['customerID'] as int,
            row['flightID'] as int,
            row['reservationDate'] as String,
            row['customerName'] as String,
            row['customerPhone'] as String,
            row['departureCity'] as String,
            row['destinationCity'] as String,
            row['departureTime'] as String,
            row['arrivalTime'] as String));
  }

  @override
  Future<List<ReservationItem>> getAllReservations() async {
    return _queryAdapter.queryList('Select * from ReservationItem',
        mapper: (Map<String, Object?> row) => ReservationItem(
            row['id'] as int,
            row['customerID'] as int,
            row['flightID'] as int,
            row['reservationDate'] as String,
            row['customerName'] as String,
            row['customerPhone'] as String,
            row['departureCity'] as String,
            row['destinationCity'] as String,
            row['departureTime'] as String,
            row['arrivalTime'] as String));
  }

  @override
  Future<void> insertReservation(ReservationItem reservation) async {
    await _reservationItemInsertionAdapter.insert(
        reservation, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateToReservations(ReservationItem itm) {
    return _reservationItemUpdateAdapter.updateAndReturnChangedRows(
        itm, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteReservation(ReservationItem reservation) {
    return _reservationItemDeletionAdapter
        .deleteAndReturnChangedRows(reservation);
  }
}
