// To parse this JSON data, do
//
//     final vendor4 = vendor4FromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Vendor4 vendor4FromJson(String str) => Vendor4.fromJson(json.decode(str));


class Vendor4 {
  Vendor4({
    required this.supplier,
    required this.image,
    required this.lamps,
    required this.area,
    required this.ok,
    required this.notOk,
    required this.timeSpan,
    required this.powerConsumed,
    required this.frequency,
    required this.ccmsList
  });

  String supplier;
  String image;
  int lamps;
  String area;
  int ok;
  int notOk;
  String timeSpan;
  String powerConsumed;
  int frequency;
  List<String> ccmsList;

  factory Vendor4.fromJson(Map<String, dynamic> json) => Vendor4(
    supplier: json["supplier"] == null ? null : json["supplier"],
    image: json["image"] == null ? null : json["image"],
    lamps: json["lamps"] == null ? null : json["lamps"],
    area: json["area"] == null ? null : json["area"],
    ok: json["ok"] == null ? null : json["ok"],
    notOk: json["not_ok"] == null ? null : json["not_ok"],
    timeSpan: json["time_span"] == null ? null : json["time_span"],
    powerConsumed: json["power_consumed"] == null ? null : json["power_consumed"],
    frequency: json["frequency"] == null ? null : json["frequency"],
    ccmsList: json["ccms_list"] == null ? [] : List<String>.from(json["ccms_list"].map((x) => x)),
  );


}
