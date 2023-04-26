// To parse this JSON data, do
//
//     final vendor1 = vendor1FromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Vendor1 vendor1FromJson(String str) => Vendor1.fromJson(json.decode(str));

class Vendor1 {
  Vendor1({
    required this.vendor,
    required this.vendorLogo,
    required this.totalStreetLights,
    required this.gridLocation,
    required this.workingUnits,
    required this.faultUnits,
    required this.period,
    required this.powerConsumed,
    required this.frequency,
    required this.ccmsList
  });

  String vendor;
  String vendorLogo;
  int totalStreetLights;
  String gridLocation;
  int workingUnits;
  int faultUnits;
  String period;
  String powerConsumed;
  int frequency;
  List<String> ccmsList;

  factory Vendor1.fromJson(Map<String, dynamic> json) => Vendor1(
        vendor: json["vendor"] == null ? null : json["vendor"],
        vendorLogo: json["vendor_logo"] == null ? null : json["vendor_logo"],
        totalStreetLights: json["total_street_lights"] == null
            ? null
            : json["total_street_lights"],
        gridLocation:
            json["grid_location"] == null ? null : json["grid_location"],
        workingUnits:
            json["working_units"] == null ? null : json["working_units"],
        faultUnits: json["fault_units"] == null ? null : json["fault_units"],
        period: json["period"] == null ? null : json["period"],
        powerConsumed:
            json["power_consumed"] == null ? null : json["power_consumed"],
        frequency: json["frequency"] == null ? null : json["frequency"],
    ccmsList: json["ccms_list"] == null ? [] : List<String>.from(json["ccms_list"].map((x) => x)),
      );
}
