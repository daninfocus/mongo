import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mongo/model/coche.dart';
import 'package:mongo_dart/mongo_dart.dart';

class DBConnectionService {
  Future<List<Coche>> getAllCoches() async {
    print('here');
    var db = await Db.create("mongodb://10.0.2.2:27017/vehiculos");
    await db.open();
    var coll = await db.collection('coches').find().toList();
    List<Coche> coches = [];
    coll.forEach((element) {
      coches.add(Coche.fromMap(element));
    });
    return coches;
  }

  Future<bool> updateCar(ObjectId id, Coche coche) async {
    var db = await Db.create("mongodb://10.0.2.2:27017/vehiculos");
    await db.open();
    var collection = db.collection('coches');
    ModifierBuilder modify = ModifierBuilder();
    modify.set('make', coche.make);
    modify.set('model', coche.model);
    modify.set('year', coche.year);
    modify.set('price', coche.price);
    modify.set('color', coche.color);
    bool finished = false;
    await collection
        .updateOne(where.eq('_id', id), modify)
        .whenComplete(() => finished = true);

    return finished;
  }

  Future<bool> addCar(Coche coche) async {
    //.find({}).sort({_id:-1}).limit(1);
    var db = await Db.create("mongodb://10.0.2.2:27017/vehiculos");
    await db.open();
    var collection = db.collection('coches');
    bool finished = false;
    await collection.insertOne({
      'make': coche.make,
      'model': coche.model,
      'year': coche.year,
      'price': coche.price,
      'color': coche.color
    }).whenComplete(() => finished = true);
    return finished;
  }

  // Future<Map<String, dynamic>> findListAll() async {
  //   await this.db;
  //   print(db);

  // }
}
