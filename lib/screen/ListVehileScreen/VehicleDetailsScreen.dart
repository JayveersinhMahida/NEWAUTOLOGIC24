import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class DetailsScreen extends StatefulWidget {
  final QueryDocumentSnapshot data;
  const DetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vehicle  Detail Screen",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.yellow,
        toolbarHeight: 80.0,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Hero(
            tag: '${widget.data['ImgUrl'][0]}',
            child: ImageSlideshow(
              children: [
                Image.network(widget.data['ImgUrl'][0]),
                Image.network(widget.data['ImgUrl'][1]),
              ],
              autoPlayInterval: 3000,
              isLoop: true,
              initialPage: 0,
            ),
          ),
          Text(widget.data['Title']),
          Text(widget.data['Price']),
          Text(widget.data['Description']),
          Text(widget.data['VehicleBrand']),
          Text(widget.data['VehicleModel']),
          Text(widget.data['VehicleYear']),
          Text(widget.data['KmDriven']),
          Text(widget.data['Phone']),
        ],
      ),
    );
  }
}
