
import 'dart:convert';

List<VendorList> vendorListFromJson(String str) => List<VendorList>.from(json.decode(str).map((x) => VendorList.fromJson(x)));


class VendorList {
  VendorList({
    required this.name,
    required this.image,
  });

  String name;
  String image;

  factory VendorList.fromJson(Map<String, dynamic> json) => VendorList(
    name: json["name"] == null ? "" : json["name"],
    image: json["image"] == null ? "" : json["image"],
  );

}
