import 'dart:async';
import 'dart:math';
import 'package:blog/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blog/homepage.dart';
import 'package:blog/welcome_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter/material.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({Key key}) : super(key: key);

  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  List<String> quotes = [
    ' An Investment in knowledge pays the best interest',
    'Change is the end result of all true learning',
    'The roots of education are bitter, but the fruit is sweet',
    'The learning process continues until the day you die',
    'Education is not the filling of a pail, but the lighting of a fire',
    ' Education is not preparation for life; education is life itself',
    'Education is a better safeguard of liberty than a standing army',
    'Nine-tenths of education is encouragement',
    'Educating the mind without educating the heart is no education at all',
    'Learning is not compulsory. Neither is survival',
  ];
  // int x = 0;
  int x = Random().nextInt(10);
  final _auth = FirebaseAuth.instance;
  void initState() {
    // TODO: implement initState
    super.initState();
    getcurrentuser();
    Timer(Duration(seconds: 8), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => userstate == true ? WelcomeScreen() : homescreen()));
    });
  }

  bool userstate;
  void getcurrentuser() async {
    try {
      final user = await _auth.currentUser;
      userstate = user == null ? true : false;
    } catch (e) {
      print(e);
    }
  }
  // var ud1 = "";
  // void getvalue() async {
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   setState(() {
  //     String a = pref.getString('email');
  //     if (a != null) {
  //       ud1 = a;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Image.asset(
              "assets/Collab.gif",
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    quotes[x],
                    style: const TextStyle(
                        fontSize: 25,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          )),
          const Padding(
            padding: EdgeInsetsDirectional.only(bottom: 50),
            child: SpinKitPouringHourGlass(
              color: Colors.black,
              size: 50,
            ),
          )
        ],
      ),
    );
  }
}
