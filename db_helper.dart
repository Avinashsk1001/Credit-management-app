import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
//import 'package:sqflite/sqlite_api.dart';

class DBHelper{
  static Future<sql.Database> database()async{
    final dbPath=await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath,'users.db'),
    onCreate: (db,version)async{
      return await db.execute(
        'CREATE TABLE users(email TEXT PRIMARY KEY,name TEXT,credits TEXT)');
      },version: 1);
  }
  static Future<void> insert(String table, Map<String, Object> data)async{
    final db=await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm:sql.ConflictAlgorithm.replace
       );
  }

  static Future<List<Map<String,dynamic>>> getData(String table)async{
    final db=await DBHelper.database();
    return db.query(table);
  }

  static Future<sql.Database> database1()async{
    final dbPath=await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath,'transactions.db'),
    onCreate:(db,version)async{
      return await db.execute(
        'CREATE TABLE transactions(id TEXT PRIMARY KEY,credits TEXT,receiver TEXT)'
      );
    },version: 1);
  }

  static Future<void> insert1(String table,Map<String,Object>data)async{
    final db=await DBHelper.database1();
    db.insert(table,data,conflictAlgorithm:sql.ConflictAlgorithm.replace);
  }

  static Future<void> update(Map<String,Object> usr)async{
    final db=await DBHelper.database();
    await db.update(
      'users',
       usr,
       where:'email=?',
       whereArgs:[usr['email']]
       );
  }

  static Future<List<Map<String,dynamic>>> getData1(String table)async{
    final db=await DBHelper.database1();
    return db.query(table);
  }
}
