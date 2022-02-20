import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mongo/model/coche.dart';
import 'package:mongo_dart/mongo_dart.dart';

class DBConnectionService {
  Future<List<Coche>> getAllCoches() async {
    print('here');
    var db = await Db.create("mongodb://localhost:27017/vehiculos");
    await db.open();
    var coll = await db.collection('coches').find().toList();
    List<Coche> coches = [];
    coll.forEach((element) {
      print(element['id']);
      coches.add(Coche.fromMap(element));
    });
    return coches;
  }

  // Future<Map<String, dynamic>> findListAll() async {
  //   await this.db;
  //   print(db);

  // }
}
