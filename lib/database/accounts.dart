// ignore_for_file: empty_constructor_bodies, prefer_conditional_assignment, unused_local_variable, unnecessary_this

import 'package:budget_x/model/note.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Accounts {
  static Accounts? _accounts;
  static Database? _database;

  String noteTable = 'noteTable';
  String colUsername = 'username';
  String colName = 'name';
  String colEmail = 'email';
  String colPassword = 'password';
  String colNumber = 'number';

  Accounts._createInstance();

  factory Accounts() {
    if (_accounts == null) {
      _accounts = Accounts._createInstance();
    }
    return _accounts!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'accounts.db';
    var accountsDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return accountsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        '''CREATE TABLE $noteTable($colUsername TEXT NOT NULL,
                                   $colName TEXT NOT NULL,
                                   $colEmail TEXT NOT NULL,
        $colPassword TEXT NOT NULL,
        $colNumber TEXT NOT NULL)''');
  }

  Future<int> saveData(Note note) async {
    Database db = await this.database;
    var res = await db.insert(noteTable, note.toMap());
    return res;
  }

  Future<List<Note>> getLoginUser(String username, String password) async {
    var db = await this.database;
    var res = await db.rawQuery('''SELECT * FROM $noteTable WHERE 
        $colUsername = $username AND 
        $colPassword = $password''');

    if (res.isNotEmpty) {
      return res.map((e) => Note.fromMapObject(e)).toList();
    }
    return null!;
  }

  Future<int> updateUser(Note note) async {
    var db = await this.database;
    var res = await db.update(noteTable, note.toMap(),
        where: '$colUsername=?', whereArgs: [note.username]);
    return res;
  }
}
