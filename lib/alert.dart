import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Alert extends StatefulWidget {
  @override
  _AlertState createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  final textFieldController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String details;
  String Suggestion;
  final _firestore = FirebaseFirestore.instance;
  void getcurrentuser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        details = user.email;

        print(details);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getcurrentuser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueGrey,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/1.jpg"), fit: BoxFit.fill)),
        height: 500,
        width: 500,
        child: AlertDialog(
          title: Text('Suggestion Box'),
          content: TextField(
            onChanged: (value) {
              Suggestion = value;
            },
            controller: textFieldController,
            decoration: InputDecoration(hintText: "Enter Your Suggestion "),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                try {
                  if (Suggestion != null) {
                    _firestore.collection('Suggestion').add({
                      'text': Suggestion,
                      'sender': details,
                      'timestamp': FieldValue.serverTimestamp(),
                    });
                    Fluttertoast.showToast(
                      msg: "Your Responce Was  Saved Successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                    Navigator.pop(context);
                  }
                } catch (e) {
                  Fluttertoast.showToast(
                    msg: e.toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                }
                //save in firestore

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
