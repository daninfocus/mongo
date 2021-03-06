// To parse this JSON data, do
//
//     final coche = cocheFromMap(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

class Coches {
  Coches({
    required this.coches,
  });

  List<Coche> coches;

  factory Coches.fromJson(String str) => Coches.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Coches.fromMap(Map<String, dynamic> json) => Coches(
        coches: List<Coche>.from(json["coches"].map((x) => Coche.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "coches": List<dynamic>.from(coches.map((x) => x.toMap())),
      };
}

class Coche {
  Coche({
    this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.price,
  });

  ObjectId? id;
  String make;
  String model;
  int year;
  String color;
  String price;

  factory Coche.fromJson(String str) => Coche.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Coche.fromMap(Map<String, dynamic> json) => Coche(
        id: json["_id"],
        make: json["make"],
        model: json["model"],
        year: json["year"].toInt(),
        color: json["color"],
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "make": make,
        "model": model,
        "year": year,
        "color": color,
        "price": price,
      };
}
