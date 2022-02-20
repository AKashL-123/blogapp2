import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:blog/service/fc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class createphotoscreen extends StatefulWidget {
  @override
  _createphotoscreenState createState() => _createphotoscreenState();
}

class _createphotoscreenState extends State<createphotoscreen> {
  File crop;
  String event;
  String date;
  fcstore fc = fcstore();
  var _image;
  bool loading = false;
  FirebaseStorage storage = FirebaseStorage.instance;
  var type;
  final ImagePicker imagePicker = ImagePicker();
  Future getimage() async {
    XFile image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
              toolbarColor: Colors.lightBlueAccent,
              toolbarTitle: "Cropper",
              statusBarColor: Colors.deepOrange[900],
              backgroundColor: Colors.white));
      setState(() {
        if (cropped != null) {
          crop = cropped;
          _image = cropped.path;
        }
      });
    }
  }

  uploadblog() async {
    if (_image != null || date != null || event != null) {
      setState(() {
        loading = true;
      });
      Reference ref = storage
          .ref()
          .child("Photoswall")
          .child("${randomAlpha(8)} ${event}.jpg");
      UploadTask uploadTask = ref.putFile(crop);
      uploadTask.whenComplete(() async {
        var url = await ref.getDownloadURL();
        Map<String, dynamic> photodata = {
          "imageurl": url,
          "event": event,
          "date": date,
          'timestamp': FieldValue.serverTimestamp(),
        };
        setState(() {
          loading = false;
        });
        fc.addphotodata(photodata).then((result) => Navigator.pop(context));
        Fluttertoast.showToast(
          msg: "Photo Uploaded Successfully ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Upload Photo wall",
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontFamily: 'Montserrat'),
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_left_sharp),
              color: Colors.black,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: IconButton(
                onPressed: () {
                  uploadblog();
                },
                icon: Icon(Icons.upload_file),
                color: Colors.black,
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: ModalProgressHUD(
            inAsyncCall: loading,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        getimage();
                      },
                      child: _image != null
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(_image),
                                      ))),
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.rectangle),
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                              child: Icon(
                                Icons.add_a_photo,
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(children: [
                          TextFormField(
                              autofocus: false,
                              onChanged: (val) {
                                setState(() {
                                  event = val;
                                });
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.event),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Event",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                              autofocus: false,
                              onChanged: (val) {
                                setState(() {
                                  date = val;
                                });
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.date_range),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "date",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),
                        ]))
                  ],
                ),
              ),
            )));
  }
}
