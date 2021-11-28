import 'package:autologic/constants/constants.dart';

class SaveData {
  SaveData(
      {required this.brand,
      required this.km,
      required this.price,
      required this.model,
      required this.pickDate,
      required this.pickTime,
      required this.id,
      this.address,
      this.latitude,
      this.longitude,
      this.isMoving,
      required this.vehicleNumber});
  String brand;
  String model;
  String km;
  String vehicleNumber;
  String pickDate;
  String pickTime;
  String id;
  int price;
  late String? address;
  late double? longitude;
  late double? latitude;
  late String? isMoving;
}
