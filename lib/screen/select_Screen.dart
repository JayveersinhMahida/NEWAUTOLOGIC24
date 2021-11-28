import 'package:autologic/constants/constants.dart';
import 'package:autologic/models/Vmodel.dart';
import 'package:autologic/models/brandmodel.dart';
import 'package:autologic/models/savedataModel.dart';
import 'package:autologic/screen/MapScreen.dart';
import 'package:autologic/screen/SellVehicle/SellVehicleScreen.dart';
import 'package:autologic/services/Apiservices.dart';
import 'package:autologic/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _selectedvalue = "Hero";
  late String _id = "1";
  String _selectModel = "Hero Splendor Plus+";
  String _kmtokm = "0 - 3000km";
  String _timepick = "9:00am - 12:00pm";
  late int _servicePrice;
  int def = 0;
  int def2 = 0;
  String _pick = "Service Date";
  BrandData? data;
  late bool _loading = true;
  List<Record>? brand;
  ModelData? modelData;
  List<Vehiclemodel>? vehiclemodel;

  DateTime selectedDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 15));
  DateTime? date;
  final contro = Get.find<AuthService>();
  TextEditingController vehicleNo = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  ///////
  ///
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    data = await ApiServices.getBrand();
    brand = data!.records;
    print(data);

    print(data!.records![0].vehicleBrand);
    getModel();

    print(selectedDate);
    setState(() {
      _loading = false;
    });
  }

  getModel() async {
    modelData = await ApiServices.getModel(_id);
    setState(() {
      vehiclemodel = modelData!.vehiclemodel;
      _selectModel = vehiclemodel![0].vehicleModel!;
    });
  }

  ///////////////
  ///
  ///
  ///
  ///
  Future _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: endDate);
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;

        // print(picked.timeZoneName);
      });
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.yellow,
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          toolbarHeight: 80.0,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/boy.json",
                width: 100,
                height: 100.0,
              ),
              Spacer(),
              Text(
                "Booking Service",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              Spacer(),
            ],
          ),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    color: Colors.yellowAccent,
                    child: Image.asset(
                      logo,
                      fit: BoxFit.scaleDown,
                    ),
                  )),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                title: Text(
                  "Account Details",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                leading: Icon(
                  Icons.people,
                  color: Colors.black,
                ),
                title: Text(
                  "About-us",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                onTap: () {
                  Get.to(() => SellScreen());
                },
                leading: Icon(
                  Icons.sell,
                  color: Colors.black,
                ),
                title: Text(
                  "Sell Vehicle",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                onTap: () {
                  Get.defaultDialog(
                    content: Text(
                      "Are You Sure Want to \nLogout?",
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    confirm: ElevatedButton(
                      onPressed: () {
                        AuthService().signOut();
                        Get.back();
                      },
                      child: Text("Yes"),
                    ),
                    cancel: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("No"),
                    ),
                  );
                },
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ),
                title: Text(
                  "Logout",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: _loading
            ? Center(child: loading)
            : Container(
                // height: height,
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // const SizedBox(
                        //   height: 10.0,
                        // ),
                        Text(
                          " Select Your Vehicle Brand",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        // const SizedBox(
                        //   height: 20.0,
                        // ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            // color: Colors.black87,

                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedvalue,
                                items: brand?.map((b) {
                                  return DropdownMenuItem(
                                      value: b.vehicleBrand.toString(),
                                      onTap: () {
                                        setState(() {
                                          _selectedvalue = b.vehicleBrand!;
                                          print("aa $_selectedvalue");
                                          _id = b.id!;
                                          // _selectModel = "";
                                        });
                                      },
                                      child: Text(b.vehicleBrand!.toString()));
                                }).toList(),
                                hint: const Text("Select Your Brand"),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedvalue = value.toString();
                                    print(_selectedvalue);
                                    // _id = value.toString();
                                    getModel();
                                  });
                                },
                                // value: _selectedvalue,
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 20.0,
                        // ),
                        Text(
                          "Select Your Vehicle Model",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        // const SizedBox(
                        //   height: 20.0,
                        // ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            // color: Colors.black87,

                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton(
                                // disabledHint: Text("Select Your Model"),
                                isExpanded: true,
                                value: _selectModel,
                                items: vehiclemodel?.map((item) {
                                  return DropdownMenuItem(
                                    value: item.vehicleModel,
                                    onTap: () {
                                      setState(() {
                                        _selectModel =
                                            item.vehicleModel.toString();
                                        _servicePrice =
                                            int.parse(item.servicePrice!);
                                        print(_servicePrice);
                                      });
                                    },
                                    child: Text(item.vehicleModel.toString()),
                                  );
                                }).toList(),
                                hint: const Text("Select Your Model"),
                                onChanged: (value) {
                                  setState(() {
                                    _selectModel = value.toString();
                                  });
                                },
                                // value: _selectModel,
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 25.0,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            height: 50.0,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: km.length,
                                itemBuilder: (context, index) {
                                  final kmto = km[index];
                                  // return Text("km");
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ChoiceChip(
                                      elevation: 1.0,
                                      // disabledColor: Colors.blue,
                                      selectedColor: Colors.yellowAccent,
                                      // padding: const EdgeInsets.symmetric(
                                      //   horizontal: 10.0,
                                      //   vertical: 10.0,
                                      // ),
                                      pressElevation: 0.0,
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                      label: Text(
                                        kmto,
                                      ),
                                      selected: def == index,
                                      onSelected: (value) {
                                        setState(() {
                                          def = value ? index : def;
                                          _kmtokm = kmto;
                                          print(_kmtokm);
                                        });
                                      },
                                    ),
                                  );
                                }),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 15.0,
                        // ),
                        const Text(
                          "Enter Your Vehicle Number ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            // fontWeight: FontWeight.w500,
                          ),
                        ),
                        // const SizedBox(
                        //   height: 10.0,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextFormField(
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Vehicle Number";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.characters,
                            controller: vehicleNo,
                            decoration: InputDecoration(
                              hintText: "GJ 23 XX 0000",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 15.0,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              _pick,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                // fontWeight: FontWeight.w500,
                              ),
                            ),
                            ElevatedButton.icon(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.yellowAccent),
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 55.0, vertical: 10.0),
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                DateTime date = await _selectDate(context);
                                var pick =
                                    DateFormat("dd-MM-yyyy").format(date);

                                print(_pick);
                                setState(() {
                                  _pick = pick;
                                });
                              },
                              icon: const Icon(
                                Icons.calendar_today,
                                color: Colors.black,
                              ),
                              label: const Text(
                                "Date",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            height: 50.0,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: times.length,
                                itemBuilder: (context, index) {
                                  final timeto = times[index];
                                  // return Text("km");
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ChoiceChip(
                                      elevation: 1.0,
                                      // disabledColor: Colors.blue,
                                      selectedColor: Colors.yellowAccent,
                                      // padding: const EdgeInsets.symmetric(
                                      //   horizontal: 10.0,
                                      //   vertical: 10.0,
                                      // ),
                                      pressElevation: 0.0,
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                      label: Text(
                                        timeto,
                                        // style: TextStyle(
                                        //   color: Colors.black,
                                        //   fontSize: 18.0,
                                        //   fontWeight: FontWeight.w600,
                                        // ),
                                      ),
                                      selected: def2 == index,
                                      onSelected: (value) {
                                        setState(() {
                                          def2 = value ? index : def;
                                          _timepick = timeto;
                                          print(_timepick);
                                        });
                                      },
                                    ),
                                  );
                                }),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate() &&
                                _pick != "Service Date") {
                              final data = SaveData(
                                id: contro.user.value!.uid,
                                price: _servicePrice,
                                brand: _selectedvalue,
                                km: _kmtokm,
                                model: _selectModel,
                                pickDate: _pick,
                                pickTime: _timepick,
                                vehicleNumber: vehicleNo.text,
                              );
                              Get.to(() => MapScreen(data: data));
                              print(
                                  "${data.brand + data.km + data.model + data.pickDate + data.pickTime + data.vehicleNumber + data.brand}");
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (_) => MapScreen(
                              //               data: data,
                              //             )));
                            } else if (_pick == "Service Date") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Please pick Service Date")));
                            }
                          },
                          child: Text(
                            "Next",
                            style:
                                TextStyle(color: Colors.black, fontSize: 25.0),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.yellowAccent),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 85.0, vertical: 10.0),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
