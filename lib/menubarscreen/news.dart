import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class news extends StatefulWidget {
  news({this.title, this.link, this.description});
  String title;
  String description;
  String link;
  @override
  _newsState createState() => _newsState();
}

class _newsState extends State<news> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_left_sharp,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Expanded(
                child: Text(widget.title,
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'lightitalic',
                        fontWeight: FontWeight.w900)),
              ),
            ),
            Center(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("News Description :",
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'myralight',
                                fontWeight: FontWeight.w800,
                                decoration: TextDecoration.underline,
                              )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.description),
                  )
                ],
              ),
            ),
            widget.link != "null"
                ? Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black87,
                    child: Container(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.yellow.withAlpha(5000),
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: Offset(0, 0),
                            )
                          ],
                          gradient: LinearGradient(
                              colors: [Color(0xFFFFC107), Color(0XFFF57F17)],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: MaterialButton(
                          onPressed: () async {
                            final url = widget.link;
                            try {
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Error Cant Register",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                ); // can't launch url
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Text(
                            "Register",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
