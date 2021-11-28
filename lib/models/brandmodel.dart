// To parse this JSON data, do
//
//     final brandData = brandDataFromJson(jsonString);

import 'dart:convert';

BrandData brandDataFromJson(String str) => BrandData.fromJson(json.decode(str));

String brandDataToJson(BrandData data) => json.encode(data.toJson());

class BrandData {
  BrandData({
    this.records,
  });

  List<Record>? records;

  factory BrandData.fromJson(Map<String, dynamic> json) => BrandData(
        records: json["records"] == null
            ? null
            : List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "records": records == null
            ? null
            : List<dynamic>.from(records!.map((x) => x.toJson())),
      };
}

class Record {
  Record({
    this.id,
    this.vehicleBrand,
  });

  String? id;
  String? vehicleBrand;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["id"] == null ? null : json["id"],
        vehicleBrand:
            json["vehicle_brand"] == null ? null : json["vehicle_brand"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "vehicle_brand": vehicleBrand == null ? null : vehicleBrand,
      };
}
