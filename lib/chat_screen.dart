import 'package:blog/constants.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

final _firestore = FirebaseFirestore.instance;

var userdetails;

class ChatScreen extends StatefulWidget {
  static String id = "chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final textcontoller = TextEditingController();

  String messagetext;

  dynamic user;
  String userEmail;
  String userPhoneNumber;

  @override
  void initState() {
    getcurrentuser();
    super.initState();
  }

  void getcurrentuser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        userdetails = user.email;

        print(userdetails);
      }
    } catch (e) {
      print(e);
    }
  }

  void messagestream() async {
    await for (var snapshot in _firestore.collection('message').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textcontoller,
                      onChanged: (value) {
                        messagetext = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      textcontoller.clear();

                      try {
                        if (messagetext != null) {
                          _firestore.collection('message').add({
                            'text': messagetext,
                            'sender': userdetails,
                            'timestamp': FieldValue.serverTimestamp(),
                          });
                          print(userdetails);
                        }
                      } catch (e) {
                        Fluttertoast.showToast(
                          msg: e.toString(),
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                      }
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  _ChatScreenState cs = _ChatScreenState();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection("message")
          .orderBy('timestamp', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.blueAccent,
          ));
        }
        final messages = snapshot.data.docs.reversed;
        List<Messagebuble> TW = [];
        for (var message in messages) {
          final mt = message.data()['text'];
          final ms = message.data()['sender'];
          print(userdetails);
          final user = userdetails;

          final messagebuble = Messagebuble(
              messagetext: mt, sender: ms, userme: user == ms ? true : false);
          TW.add(messagebuble);
        }
        return Expanded(
            child: ListView(
          reverse: true,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: TW,
        ));
      },
    );
  }
}

class Messagebuble extends StatelessWidget {
  Messagebuble({this.messagetext, this.sender, this.userme});
  final String messagetext;
  final String sender;
  bool userme;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            userme == true ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            "${sender.toString().split('@')[0]}",
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.only(
                topLeft:
                    userme == true ? Radius.circular(30) : Radius.circular(0),
                topRight:
                    userme == true ? Radius.circular(0) : Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            color: userme == true ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                "$messagetext",
                style: TextStyle(
                    fontSize: 15,
                    color: userme == true ? Colors.white : Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
