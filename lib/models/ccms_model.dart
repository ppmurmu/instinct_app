// To parse this JSON data, do
//
//     final ccmsModel = ccmsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<CcmsModel> ccmsModelFromJson(String str) => List<CcmsModel>.from(json.decode(str).map((x) => CcmsModel.fromJson(x)));


class CcmsModel {
  CcmsModel({
    required this.energydataid,
    required this.a1,
    required this.a2,
    required this.a3,
    required this.dateTime,
    required this.kva1,
    required this.kva2,
    required this.kva3,
    required this.kvah,
    required this.kvar1,
    required this.kvar2,
    required this.kvar3,
    required this.kvarh,
    required this.kw1,
    required this.kw2,
    required this.kw3,
    required this.kwh,
    required this.pf1,
    required this.pf2,
    required this.pf3,
    required this.phase,
    required this.slaveId,
    required this.v1,
    required this.v2,
    required this.v3,
    required this.freq,
    required this.kva,
    required this.kvar,
    required this.kw,
    required this.pf,
    required this.switchId,
  });

  int energydataid;
  double a1;
  double a2;
  double a3;
  String dateTime;
  double kva1;
  double kva2;
  double kva3;
  double kvah;
  double kvar1;
  double kvar2;
  double kvar3;
  double kvarh;
  double kw1;
  double kw2;
  double kw3;
  double kwh;
  double pf1;
  double pf2;
  double pf3;
  int phase;
  String slaveId;
  double v1;
  double v2;
  double v3;
  double freq;
  double kva;
  double kvar;
  double kw;
  double pf;
  int switchId;

  factory CcmsModel.fromJson(Map<String, dynamic> json) => CcmsModel(
    energydataid: json["energydataid"] == null ? 0 : json["energydataid"],
    a1: json["a1"] == null ? 0 : json["a1"].toDouble(),
    a2: json["a2"] == null ? 0 : json["a2"].toDouble(),
    a3: json["a3"] == null ? 0 : json["a3"],
    dateTime: json["date_time"] == null ? "" : json["date_time"],
    kva1: json["kva1"] == null ? 0 : json["kva1"].toDouble(),
    kva2: json["kva2"] == null ? 0 : json["kva2"].toDouble(),
    kva3: json["kva3"] == null ? 0 : json["kva3"],
    kvah: json["kvah"] == null ? 0 : json["kvah"].toDouble(),
    kvar1: json["kvar1"] == null ? 0 : json["kvar1"].toDouble(),
    kvar2: json["kvar2"] == null ? 0 : json["kvar2"].toDouble(),
    kvar3: json["kvar3"] == null ? 0 : json["kvar3"],
    kvarh: json["kvarh"] == null ? 0 : json["kvarh"].toDouble(),
    kw1: json["kw1"] == null ? 0 : json["kw1"].toDouble(),
    kw2: json["kw2"] == null ? 0 : json["kw2"].toDouble(),
    kw3: json["kw3"] == null ? 0 : json["kw3"],
    kwh: json["kwh"] == null ? 0 : json["kwh"].toDouble(),
    pf1: json["pf1"] == null ? 0 : json["pf1"].toDouble(),
    pf2: json["pf2"] == null ? 0 : json["pf2"].toDouble(),
    pf3: json["pf3"] == null ? 0 : json["pf3"],
    phase: json["phase"] == null ? 0 : json["phase"],
    slaveId: json["slave_id"] == null ? "" : json["slave_id"],
    v1: json["v1"] == null ? 0 : json["v1"].toDouble(),
    v2: json["v2"] == null ? 0 : json["v2"].toDouble(),
    v3: json["v3"] == null ? 0 : json["v3"],
    freq: json["freq"] == null ? 0 : json["freq"].toDouble(),
    kva: json["kva"] == null ? 0 : json["kva"].toDouble(),
    kvar: json["kvar"] == null ? 0 : json["kvar"].toDouble(),
    kw: json["kw"] == null ? 0 : json["kw"].toDouble(),
    pf: json["pf"] == null ? 0 : json["pf"].toDouble(),
    switchId: json["switch_id"] == null ? 0 : json["switch_id"],
  );


}
