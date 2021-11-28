import 'package:autologic/screen/ListVehileScreen/VehicleDetailsScreen.dart';
import 'package:autologic/services/Database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListVehicleScreen extends StatefulWidget {
  const ListVehicleScreen({Key? key}) : super(key: key);

  @override
  _ListVehicleScreenState createState() => _ListVehicleScreenState();
}

class _ListVehicleScreenState extends State<ListVehicleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        toolbarHeight: 80.0,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Vehicles list",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder(
          future: Database("").getVehicleforsell(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snap) {
            if (snap.hasData) {
              final QuerySnapshot data = snap.data;
              return GridView.builder(
                  padding: EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.80,
                  ),
                  itemCount: data.docs.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => DetailsScreen(
                              data: data.docs[index],
                            ));
                      },
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Hero(
                              tag: '${data.docs[index]['ImgUrl'][0]}',
                              child: Image.network(
                                data.docs[index]['ImgUrl'][0].toString(),
                                scale: 2.0,
                                width: double.infinity,
                                height: 180,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Text(
                              data.docs[index]['Title'].toString(),
                            ),
                            Text(
                              data.docs[index]['Price'].toString(),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
