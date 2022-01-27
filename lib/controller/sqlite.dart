import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:seat_geek_flutter/models/favourite.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class DbHelper{
  static Database? _db;
  Future<Database?> get db async{
    if(_db != null) return _db;
    _db = await initDb();
    return _db;
  }
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "seat_geek.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }
  void _onCreate(Database db, int version) async{
    // When creating the db, create the table
    await db.rawQuery("CREATE TABLE IF NOT EXISTS favourite(id INTEGER PRIMARY KEY AUTOINCREMENT,title VARCHAR(150) NOT NULL,event_id INTEGER NOT NULL,location VARCHAR(50),event_time VARCHAR(100),photo VARCHAR(300))");
    debugPrint("Created tables");
  }

  Future<int> addFavourite(Favourite favourite)async{
    var dbClient = await db;
    Map<String,String> _values = {};
    _values.putIfAbsent('title', () => favourite.title!);
    _values.putIfAbsent('event_id', () => favourite.eventId!);
    _values.putIfAbsent('location', () => favourite.location!);
    _values.putIfAbsent('event_time', () => favourite.eventTime!);
    _values.putIfAbsent('photo', () => favourite.photo!);
    return await dbClient!.insert('favourite', _values);
  }
  Future<int> deleteExpense(Favourite favourite)async{
    var dbClient = await db;
    return await dbClient!.delete('favourite',where: "event_id = ?",whereArgs: [favourite.eventId ]);
  }

  Future<List<Favourite>> getFavourites()async{
    List<Favourite> _favourites = [];
    var dbClient = await db;
    List<Map> _list = await dbClient!.rawQuery('SELECT * FROM favourite');
    for(Map income in _list){
      _favourites.add(Favourite(id:income['id'],title: income['title'],eventId: income['event_id'].toString(),eventTime: income['event_time'],location: income['location'],photo: income['photo']));
    }
    return _favourites;
  }
}