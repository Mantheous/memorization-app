import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableFlashcards = 'flashcards';
final String columnId = '_id';
final String columnReference = 'reference';
final String columnTargetRetention = 'targetRetention';
final String columnDueDate = 'dueDate';
final String columnTimeAllowedPerReview = 'timeAllowedPerReview';

class Flashcard {
  int? id;
  String reference;
  double targetRetention;
  DateTime dueDate;
  int timeAllowedPerReview;

  Flashcard({
    this.id,
    required this.reference,
    required this.targetRetention,
    required this.dueDate,
    required this.timeAllowedPerReview,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnReference: reference,
      columnTargetRetention: targetRetention,
      columnDueDate: dueDate.toIso8601String(),
      columnTimeAllowedPerReview: timeAllowedPerReview,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  static Flashcard fromMap(Map<String, dynamic> map) {
    return Flashcard(
      id: map[columnId],
      reference: map[columnReference],
      targetRetention: map[columnTargetRetention],
      dueDate: DateTime.parse(map[columnDueDate]),
      timeAllowedPerReview: map[columnTimeAllowedPerReview],
    );
  }
}

class FlashcardDatabaseHelper {
  static final FlashcardDatabaseHelper _instance = FlashcardDatabaseHelper._internal();
  factory FlashcardDatabaseHelper() => _instance;
  static Database? _database;

  FlashcardDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'flashcards_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableFlashcards (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnReference TEXT NOT NULL,
        $columnTargetRetention REAL NOT NULL,
        $columnDueDate TEXT NOT NULL,
        $columnTimeAllowedPerReview INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insert(Flashcard flashcard) async {
    Database db = await database;
    return await db.insert(tableFlashcards, flashcard.toMap());
  }

  Future<Flashcard?> getFlashcard(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      tableFlashcards,
      columns: [columnId, columnReference, columnTargetRetention, columnDueDate, columnTimeAllowedPerReview],
      where: '$columnId = ?',
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return Flashcard.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Flashcard>> getAllFlashcards() async {
    Database db = await database;
    var result = await db.query(tableFlashcards);
    return result.map((map) => Flashcard.fromMap(map)).toList();
  }

  Future<int> update(Flashcard flashcard) async {
    Database db = await database;
    return await db.update(
      tableFlashcards,
      flashcard.toMap(),
      where: '$columnId = ?',
      whereArgs: [flashcard.id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete(
      tableFlashcards,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    Database db = await database;
    db.close();
  }
}

