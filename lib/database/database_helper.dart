// ignore_for_file: depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._();

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    await initDB();
    return _database!;
  }

  Future<void> initDB() async {
    try {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'academia.db');
      _database = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS usuarios (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                nome TEXT,
                sobrenome TEXT,
                dataNascimento TEXT,
                fotoPerfil TEXT,
                senha TEXT,
                salt TEXT,
                email TEXT,
                telefone TEXT,
                telefoneEmergencia TEXT
              );
          ''');
        },
      );
    } catch(e) {
      print(e);
    }
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}