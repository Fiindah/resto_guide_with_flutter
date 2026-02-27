import 'package:resto_app/data/model/resto_list_response.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabaseService {
  static const String _databaseName = 'resto_app.db';
  static const String _tableName = 'favorites';
  static const int _version = 1;

  Future<Database> _initializeDb() async {
    final path = join(await getDatabasesPath(), _databaseName);

    return openDatabase(
      path,
      version: _version,
      onCreate: (database, version) async {
        await database.execute(
          '''
          CREATE TABLE $_tableName(
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            pictureId TEXT,
            city TEXT,
            rating REAL
          )
          '''
        );
      },
    );
  }

  Future<int> insertItem(Restaurant restaurant) async {
    final db = await _initializeDb();
    return await db.insert(
      _tableName,
      restaurant.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Restaurant>> getAllItems() async {
    final db = await _initializeDb();
    final results = await db.query(_tableName);

    return results.map((e) => Restaurant.fromJson(e)).toList();
  }

  Future<Restaurant?> getItemById(String id) async {
    final db = await _initializeDb();
    final results =
        await db.query(_tableName, where: "id = ?", whereArgs: [id]);

    return results.isEmpty ? null : Restaurant.fromJson(results.first);
  }

  Future<int> removeItem(String id) async {
    final db = await _initializeDb();
    return await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
  }
}