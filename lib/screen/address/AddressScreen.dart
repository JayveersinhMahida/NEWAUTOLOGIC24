import 'package:autologic/models/locationModel.dart';
import 'package:autologic/models/savedataModel.dart';
import 'package:autologic/screen/ServiceScreen/ServicesScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressScreen extends StatefulWidget {
  final LocationData data;
  final SaveData detail;
  const AddressScreen({Key? key, required this.data, required this.detail})
      : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController _street = TextEditingController();
  TextEditingController _local = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  TextEditingController _area = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(widget.data.city);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          toolbarHeight: 80.0,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Add Address",
            style: GoogleFonts.montserrat(
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
            child: SingleChildScrollView(
          child: Form(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _street..text = widget.data.street,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Street',
                      hintText: 'Enter Street',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _local..text = widget.data.area,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Locality/town',
                      hintText: 'Enter Locality/town',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _pincode..text = widget.data.pincode,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Pincode',
                      hintText: 'Enter pincode',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _area..text = widget.data.city,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Area',
                      hintText: 'Enter Area',
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.to(() => ServicesScreen(
                            data: widget.detail,
                            loc: widget.data,
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.yellow,
                      minimumSize: Size(200, 50),
                    ),
                    child: Text(
                      "Save",
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                      ),
                    ))
              ],
            ),
          )),
        )),
      ),
    );
  }
}
