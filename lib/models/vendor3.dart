// To parse this JSON data, do
//
//     final vendor3 = vendor3FromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Vendor3 vendor3FromJson(String str) => Vendor3.fromJson(json.decode(str));


class Vendor3 {
  Vendor3({
    required this.title,
    required this.logo,
    required this.total,
    required this.coordinate,
    required this.ok,
    required this.notOk,
    required this.timeSpan,
    required this.powerConsumed,
    required this.frequency,
    required this.ccmsList
  });

  String title;
  String logo;
  int total;
  String coordinate;
  int ok;
  int notOk;
  String timeSpan;
  String powerConsumed;
  int frequency;
  List<String> ccmsList;

  factory Vendor3.fromJson(Map<String, dynamic> json) => Vendor3(
    title: json["title"] == null ? null : json["title"],
    logo: json["logo"] == null ? null : json["logo"],
    total: json["total"] == null ? null : json["total"],
    coordinate: json["coordinate"] == null ? null : json["coordinate"],
    ok: json["ok"] == null ? null : json["ok"],
    notOk: json["not_ok"] == null ? null : json["not_ok"],
    timeSpan: json["time_span"] == null ? null : json["time_span"],
    powerConsumed: json["power_consumed"] == null ? null : json["power_consumed"],
    frequency: json["frequency"] == null ? null : json["frequency"],
    ccmsList: json["ccms_list"] == null ? [] : List<String>.from(json["ccms_list"].map((x) => x)),
  );


}
