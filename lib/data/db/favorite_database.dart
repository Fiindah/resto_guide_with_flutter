import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteDatabase {
  static final FavoriteDatabase instance = FavoriteDatabase._init();
  static Database? _database;

  FavoriteDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('favorites.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
     CREATE TABLE favorites (
      id TEXT PRIMARY KEY,
      name TEXT,
      city TEXT,
      pictureId TEXT,
      rating REAL,
      description TEXT
    )
    ''');
  }

  // =========================
  // CRUD OPERATIONS
  // =========================

  Future<void> insertFavorite(Map<String, dynamic> data) async {
    final db = await instance.database;
    await db.insert(
      'favorites',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFavorite(String id) async {
    final db = await instance.database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await instance.database;
    return await db.query('favorites');
  }

  Future<bool> isFavorite(String id) async {
    final db = await instance.database;
    final result = await db.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }
}
