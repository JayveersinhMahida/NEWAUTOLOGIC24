import 'package:autologic/models/sellvehiclemodel.dart';
import 'package:autologic/screen/SellVehicle/uploadImageScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  TextEditingController _vehicleBrand = TextEditingController();
  TextEditingController _vehicleModel = TextEditingController();
  TextEditingController _year = TextEditingController();
  TextEditingController _kmDriven = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _dec = TextEditingController();
  TextEditingController _phoneNo = TextEditingController();
  TextEditingController _price = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          toolbarHeight: 80.0,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Upload Vehicle Details",
            style: GoogleFonts.montserrat(
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextFormField(
                      controller: _vehicleBrand,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter Brand Name";
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Vehicle Brand Name',
                        hintText: 'Vehicle Brand Name',
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: _vehicleModel,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter Model Name";
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Vehicle Model Name',
                        hintText: 'Vehicle Model Name',
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: _year,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter Model Year";
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Vehicle Model Year',
                        hintText: 'Vehicle Model Year',
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: _kmDriven,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter KM Driven";
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Km Driven',
                        hintText: 'km Driven',
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: _title,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter Ad Title";
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Ad Title',
                        hintText: 'Ad Title',
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: _dec,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter Description";
                        }
                      },
                      maxLength: 150,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Describe what you are selling*',
                        hintText: 'Describe what you are selling*',
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: _price,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter Price*";
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Price*',
                        hintText: 'Price*',
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: _phoneNo,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter your PhoneNo";
                        }
                      },
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'PhoneNo*',
                        hintText: 'PhoneNo*',
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          final sellData = Sell(
                              brand: _vehicleBrand.text,
                              dec: _dec.text,
                              model: _vehicleModel.text,
                              phone: _phoneNo.text,
                              km: _kmDriven.text,
                              price: _price.text,
                              title: _title.text,
                              year: _year.text);
                          Get.to(() => UploadImageScreen(
                                data: sellData,
                              ));
                        }
                      },
                      child: Text(
                        "Save & Next",
                        style: GoogleFonts.montserrat(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xffFF865E)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      side: BorderSide(color: Colors.red))),
                          padding: MaterialStateProperty.all(EdgeInsets.only(
                            left: 85.0,
                            right: 85.0,
                            top: 20.0,
                            bottom: 20.0,
                          ))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
