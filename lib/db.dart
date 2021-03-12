import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:remonitor/models/host.model.dart';


class DB {
  static Database db;

  static Future<Database> getInstance() async {
    if (db != null) {
      return db;
    }

    db = await openDB();
    return db;
  }

  static openDB() async => openDatabase(
    join(await getDatabasesPath(), 'hosts.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE hosts('
            'id TEXT PRIMARY KEY,'
            'name TEXT,'
            'host TEXT NOT NULL,'
            'port TEXT NOT NULL)',
      );
    },
    version: 1,
  );

}

Future<void> addHost(HostModel host) async {
  final Database db = await DB.getInstance();

  await db.insert(
    'hosts',
    host.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<HostModel>> getHosts() async {
  final Database db = await DB.getInstance();
  final List<Map<String, dynamic>> maps = await db.query('hosts');

  return List.generate(maps.length, (i) {
    return HostModel(
      id: maps[i]['id'],
      name: maps[i]['name'],
      host: maps[i]['host'],
      port: maps[i]['port'],
    );
  });
}

Future<void> deleteHost(String id) async {
  final db = await DB.getInstance();

  await db.delete(
    'hosts',
    where: "id = ?",
    whereArgs: [id],
  );
}