import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CharacterHubDatabaseContext {
  final int version = 1;
  final String databaseName = 'rick_and_morty.db';
  final String tableName = 'favorite_characters';
  late Database _database;

  Future<Database> openDb() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), databaseName),
      version: version,
      onCreate: (database, version) {
        String initialQuery = 'create table $tableName ('
            'id integer primary key,'
            'name varchar(255),'
            'status varchar(255),'
            'species varchar(255),'
            'type varchar(255),'
            'gender varchar(255),'
            'origin varchar(255),'
            'location varchar(255),'
            'image varchar(255)'
            ')';
        database.execute(initialQuery);
      },
    );
    return _database;
  }
}
