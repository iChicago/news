import 'package:sqflite/sqflite.dart';
// provide a path to actual db location
import 'package:path_provider/path_provider.dart';
// to access a directory
import 'dart:io';
// to use "join" function
import 'package:path/path.dart';
import 'dart:async';
import '../modules/item_module.dart';
import 'repository.dart';

class NewsDbProvider implements Source, Cache{
  Database db;

  NewsDbProvider(){
    init();
  }


  // todo - store and fetch top ids
  Future<List<int>> fetchTopIds(){
    return null;
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "news.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate:(Database newDb, int version){
        newDb.execute("""
          CREATE TABLE Items
          (
            id INTEGER PRIMARY KEY,
            type TEXT,
            by TEXT,
            time INTEGER,
            text TEXT,
            parent INTEGER,
            kids BLOB,
            dead INTEGER,
            deleted INTEGER,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER
          ) 
        """);
      }
    );
  }

  // columns: null ===> Projection,,, returns all columns
  Future<ItemModel> fetchItem(int id) async{
    final maps = await db.query(
                    "Items",
                    columns: null,
                    where: "id = ?",
                    whereArgs: [id],
                  );
    if(maps.length > 0){
        return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  // we didn't put async/await because we are not
  // interested in retrieving the value immediately
  Future<int> addItem(ItemModel item){
    return db.insert(
        "Items",
        item.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }


  Future<int> clearDbTable(){
    return db.delete("Items");
  }


}

final newsDbProvider = NewsDbProvider();
