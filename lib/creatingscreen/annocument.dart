import 'dart:io';
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

class createannocument extends StatefulWidget {
  @override
  _createannocumentState createState() => _createannocumentState();
}

class _createannocumentState extends State<createannocument> {
  String title;
  String description;
  String link = "null";
  String date;
  fcstore fc = fcstore();
  bool loading = false;
  var _numberController = TextEditingController();

  uploadblog() async {
    if (title != null || description != null) {
      setState(() {
        loading = true;
      });

      Map<String, dynamic> annocument = {
        "title": title,
        "description": description,
        "link": link,
        "date": date,
        'timestamp': FieldValue.serverTimestamp(),
      };
      setState(() {
        loading = false;
      });
      fc.addannocument(annocument).then((result) => Navigator.pop(context));
      Fluttertoast.showToast(
        msg: "Annocument Posted ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      Fluttertoast.showToast(
        msg: "please Fill the text Fields ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Post Annocument",
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                              autofocus: false,
                              controller: _numberController,
                              onChanged: (val) {
                                setState(() {
                                  title = val;
                                });
                              },
                              textInputAction: TextInputAction.next,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.title),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Title",
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
                                  description = val;
                                });
                              },
                              textInputAction: TextInputAction.next,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.description),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Description",
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
                                  link = val;
                                });
                              },
                              textInputAction: TextInputAction.next,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.link),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Link",
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
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.link),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Date",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
