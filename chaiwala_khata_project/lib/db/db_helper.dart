
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get db async {
    _db ??= await initDb();
    return _db!;
  }

  static Future<Database> initDb() async {
    final path = join(await getDatabasesPath(), 'chaiwala.db');
    return openDatabase(path, version: 1, onCreate: (db, v) async {
      await db.execute('CREATE TABLE customers(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)');
      await db.execute('CREATE TABLE khata(id INTEGER PRIMARY KEY AUTOINCREMENT, customerId INTEGER, type TEXT, amount REAL, date TEXT)');
    });
  }
}
