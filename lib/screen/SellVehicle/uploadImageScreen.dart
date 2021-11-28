import 'dart:io';

import 'package:autologic/models/sellvehiclemodel.dart';
import 'package:autologic/services/Database/database.dart';
import 'package:autologic/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

class UploadImageScreen extends StatefulWidget {
  final Sell data;
  const UploadImageScreen({Key? key, required this.data}) : super(key: key);

  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  final contro = Get.find<AuthService>();
  List<File> _images = [];
  List<String> imgUrls = [];
  final picker = ImagePicker();
  bool _uploading = false;
  double val = 0;

  late firebase_storage.Reference ref;

  choseImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    setState(() {
      _images.add(File(pickedFile!.path));
    });
    if (pickedFile?.path == null) getLostData();
  }

  Future<void> getLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.files != null) {
      setState(() {
        _images.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFlile() async {
    if (_images.length > 0) {
      int i = 1;
      print("chlu thai che ${_images.length}");
      for (var img in _images) {
        setState(() {
          val = i / _images.length;
        });
        ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child("images/${Path.basename(img.path)}");
        await ref.putFile(img).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            imgUrls.add(value);
            i++;
          });
        });
      }
      final id = contro.user.value!.uid;
      print(id);
      await Database(id).addVehicletoSell(
        vehicleBrand: widget.data.brand,
        vehicleModel: widget.data.model,
        vehicleYear: widget.data.year,
        kmDriven: widget.data.km,
        title: widget.data.title,
        description: widget.data.dec,
        price: widget.data.price,
        allow: false,
        imgurl: imgUrls,
        phone: widget.data.phone,
      );
    }
  }

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
            "Upload Images",
            style: GoogleFonts.montserrat(
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _uploading = true;
                });
                uploadFlile().then((value) {
                  setState(() {
                    _uploading = false;
                  });
                });
              },
              icon: Icon(
                Icons.save,
              ),
            )
          ],
        ),
        body: Container(
            child: Stack(
          children: [
            GridView.builder(
                itemCount: _images.length + 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return index == 0
                      ? Center(
                          child: IconButton(
                              onPressed: () {
                                choseImage();
                              },
                              icon: Icon(Icons.add)))
                      : Container(
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(_images[index - 1]),
                              fit: BoxFit.cover,
                            ),
                          ));
                }),
            _uploading
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: Text(
                            "Uploading...",
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CircularProgressIndicator(
                          value: val,
                          valueColor: AlwaysStoppedAnimation(Colors.green),
                        )
                      ],
                    ),
                  )
                : Container(),
          ],
        )),
      ),
    );
  }
}
