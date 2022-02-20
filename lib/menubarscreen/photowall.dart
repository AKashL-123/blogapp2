import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget photowallscreen() {
  return SafeArea(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        MessageStream(),
      ],
    ),
  );
}

class MessageStream extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection("photowall")
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
        List<phototemplate> TW = [];
        for (var message in messages) {
          final imgurl = message.data()['imageurl'];
          final event = message.data()['event'];
          final date = message.data()['date'];

          final Phototemplate = phototemplate(
            imgurl: imgurl,
            event: event,
            date: date,
          );
          TW.add(Phototemplate);
        }
        return Expanded(
            child: ListView(children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                "Photo Wall",
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),
          ListView(
            shrinkWrap: true, // 1st add
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
            children: TW,
          ),
        ]));
      },
    );
  }
}

class phototemplate extends StatelessWidget {
  phototemplate({this.date, this.event, this.imgurl});
  String date;
  String event;
  String imgurl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
            color: Colors.redAccent,
          ),
          padding: EdgeInsets.only(
            left: 25,
            right: 25,
            top: 25,
          ),
          child: Column(
            children: [
              Container(
                height: 300,
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: NetworkImage(imgurl), fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Event - ${event}",
                            style: TextStyle(
                                fontFamily: 'RM',
                                fontSize: 30,
                                fontWeight: FontWeight.w200,
                                color: Colors.white),
                          ),
                          Text("Date - ${date}",
                              style: TextStyle(
                                  fontFamily: 'RM',
                                  fontSize: 30,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white)),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
