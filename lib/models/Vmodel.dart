// To parse this JSON data, do
//
//     final modelData = modelDataFromJson(jsonString);

import 'dart:convert';

ModelData modelDataFromJson(String str) => ModelData.fromJson(json.decode(str));

String modelDataToJson(ModelData data) => json.encode(data.toJson());

class ModelData {
  ModelData({
    this.vehiclemodel,
  });

  List<Vehiclemodel>? vehiclemodel;

  factory ModelData.fromJson(Map<String, dynamic> json) => ModelData(
        vehiclemodel: json["vehiclemodel"] == null
            ? null
            : List<Vehiclemodel>.from(
                json["vehiclemodel"].map((x) => Vehiclemodel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vehiclemodel": vehiclemodel == null
            ? null
            : List<dynamic>.from(vehiclemodel!.map((x) => x.toJson())),
      };
}

class Vehiclemodel {
  Vehiclemodel({
    this.id,
    this.vehicleBrandId,
    this.vehicleModel,
    this.servicePrice,
  });

  String? id;
  String? vehicleBrandId;
  String? vehicleModel;
  String? servicePrice;

  factory Vehiclemodel.fromJson(Map<String, dynamic> json) => Vehiclemodel(
        id: json["id"] == null ? null : json["id"],
        vehicleBrandId:
            json["vehicle_brand_id"] == null ? null : json["vehicle_brand_id"],
        vehicleModel:
            json["vehicle_model"] == null ? null : json["vehicle_model"],
        servicePrice:
            json["service_price"] == null ? null : json["service_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "vehicle_brand_id": vehicleBrandId == null ? null : vehicleBrandId,
        "vehicle_model": vehicleModel == null ? null : vehicleModel,
        "service_price": servicePrice == null ? null : servicePrice,
      };
}
