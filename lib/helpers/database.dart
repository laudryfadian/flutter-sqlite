import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite/models/contact.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  final String tableName = 'contactTable';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnPhone = 'phone';
  final String columnEmail = 'email';
  final String columnCompany = 'company';

  DbHelper._internal();
  factory DbHelper() => _instance;

  Future<Database?> get _db async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database?> _initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'contact_db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnName TEXT,"
        "$columnPhone TEXT,"
        "$columnEmail TEXT,"
        "$columnCompany TEXT)";

    await db.execute(sql);
  }

  Future<int?> saveContact(Contact contact) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, contact.toMap());
  }

  Future<List?> getAllContact() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnName,
      columnPhone,
      columnEmail,
      columnCompany
    ]);

    return result.toList();
  }

  Future<int?> updateContact(Contact contact) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, contact.toMap(),
        where: '$columnId = ?', whereArgs: [contact.id]);
  }

  Future<int?> deleteContact(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
