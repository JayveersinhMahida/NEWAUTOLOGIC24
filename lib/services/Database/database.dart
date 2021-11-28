import 'package:autologic/models/savedataModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Database {
  final String uid;

  Database(this.uid);

  final CollectionReference userDatabase =
      FirebaseFirestore.instance.collection("User");

  final CollectionReference vehicleSells =
      FirebaseFirestore.instance.collection("Sell");
  final CollectionReference orders =
      FirebaseFirestore.instance.collection("Orders");

  Future updateuserData(
      {required String userName,
      required String emailid,
      required String mobileNo,
      required String role}) async {
    return await userDatabase.doc(uid).set({
      "userName": userName,
      "mobileNo": mobileNo,
      "role": role,
      "EmailId": emailid,
    });
  }

  Future addVehicletoSell({
    required String vehicleBrand,
    required String vehicleModel,
    required String vehicleYear,
    required String kmDriven,
    required String title,
    required String description,
    required String price,
    required String phone,
    required bool allow,
    required List<String> imgurl,
  }) async {
    return await vehicleSells.doc(uid).set({
      "VehicleBrand": vehicleBrand,
      "VehicleModel": vehicleModel,
      "VehicleYear": vehicleYear,
      "KmDriven": kmDriven,
      "Title": title,
      "Description": description,
      "Price": price,
      "Phone": phone,
      "Allow": allow,
      "ImgUrl": imgurl,
    });
  }

  Future createOrder({required SaveData data}) async {
    return await orders.doc().set({
      "userid": data.id,
      "brand": data.brand,
      "model": data.model,
      "date": data.pickDate,
      "time": data.pickTime,
      "isMoving": data.isMoving,
      "km": data.km,
      "price": data.price,
      "vehicleNo": data.vehicleNumber,
      "address": data.address,
      "longitude": data.longitude,
      "latitude": data.latitude,
    });
  }

  Future getVehicleforsell() async {
    return await vehicleSells.where("Allow", isEqualTo: true).get();
  }
}
