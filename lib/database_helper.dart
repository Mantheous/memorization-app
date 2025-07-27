import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  static const String _flashcardTableName = 'flashcards';
  static const String _idColName = 'id';
  static const String _refColName = 'reference';
  static const String _targetRetentionColName = 'targetRetention';
  static const String _dueDateColName = 'dueDate';
  static const String _timeAllowedPerReviewColName = 'timeAllowedPerReview';


  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('flashcards.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    // The database will require real information,
    // any secondary data must be obtained before entering
    // the data into the database.
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_flashcardTableName (
        $_idColName INTEGER PRIMARY KEY AUTOINCREMENT,
        $_refColName TEXT NOT NULL,
        $_targetRetentionColName INTEGER NOT NULL,
        $_dueDateColName TEXT NOT NULL,
        $_timeAllowedPerReviewColName INTEGER NOT NULL
      )
    ''');
  }

  Future close() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }
}
