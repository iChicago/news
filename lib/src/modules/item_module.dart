import 'dart:convert';

class ItemModel {

  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  //final poll;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  //final parts;
  final int descendants;

  ItemModel.fromJson(Map<String, dynamic> jsonItem)
      : id = jsonItem['id'],
        deleted = jsonItem['deleted'] ?? false,
        type = jsonItem['type'],
        by = jsonItem['by'],
        time = jsonItem['time'],
        text = jsonItem['text'] ?? '',
        dead = jsonItem['dead'] ?? false,
        parent = jsonItem['parent'],
        kids = jsonItem['kids'] ?? [],
        url = jsonItem['url'],
        score = jsonItem['score'],
        title = jsonItem['title'],
        descendants = jsonItem['descendants'] ?? 0;

  // 1 == 1 => true
  ItemModel.fromDb(Map<String, dynamic> dbItem)
      : id = dbItem['id'],
        deleted = dbItem['deleted'] == 1,
        type = dbItem['type'],
        by = dbItem['by'],
        time = dbItem['time'],
        text = dbItem['text'],
        dead = dbItem['dead'] == 1,
        parent = dbItem['parent'],
        kids = jsonDecode(dbItem['kids']),
        url = dbItem['url'],
        score = dbItem['score'],
        title = dbItem['title'],
        descendants = dbItem['descendants'];

  Map<String, dynamic> toMapForDb(){
    return <String, dynamic>{
    "id" : id,
    "deleted" : deleted ? 1 : 0,
    "type" : type,
    "by" : by,
    "time" : time,
    "text" : text,
    "dead" : dead ? 1 : 0,
    "parent" : parent,
    "kids" : jsonEncode(kids),
    "url" : url,
    "score" : score,
    "title" : title,
    "descendants" : descendants,
    };
  }
}