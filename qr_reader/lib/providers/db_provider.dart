import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async {
    // Path where the database is created
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          type TEXT,
          name TEXT,
          value TEXT
        )
      ''');
    });
  }

  Future<int> newScanRaw(ScanModel newScan) async {
    final id = newScan.id;
    final type = newScan.type;
    final name = newScan.name;
    final value = newScan.value;

    // Verify the db
    final db = await database;
    final res = await db!.rawInsert('''
      INSERT INTO Scans(id, type, name, value)
      VALUES( $id, '$type', '$name', '$value')
    ''');
    return res;
  }

  Future<int> newScan(ScanModel newScan) async {
    final db = await database;
    final res = await db!.insert('Scans', newScan.toJson());

    // Es el ID del último registro insertado
    return res;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db!.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db!.query('Scans');

    return res.isNotEmpty
        ? res.map<ScanModel>((s) => ScanModel.fromJson(s)).toList()
        : [];
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;
    final res = await db!.rawQuery('''
      SELECT * FROM Scans WHERE type = '$type'
    ''');

    return res.isNotEmpty
        ? res.map<ScanModel>((s) => ScanModel.fromJson(s)).toList()
        : [];
  }

  Future<int> updateScan(ScanModel newScan, String changeName) async {
    final db = await database;
    final Map<String, dynamic> row = {'name': changeName};
    final res = await db!
        .update('Scans', row, where: 'id = ?', whereArgs: [newScan.id]);
    //print(await db.query('Scans'));
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db!.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db!.rawDelete('''
      DELETE FROM Scans
    ''');
    return res;
  }
}
