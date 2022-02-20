import 'package:blog/menubarscreen/news.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget annocumentscreen() {
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
          .collection("annocument")
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
        List<annocuenttemplate> TW = [];
        for (var message in messages) {
          final title = message.data()['title'];
          final description = message.data()['description'];
          final link = message.data()['link'];
          final date = message.data()['date'];

          final Annocuenttemplate = annocuenttemplate(
            title: title,
            description: description,
            link: link,
            date: date,
          );
          TW.add(Annocuenttemplate);
        }
        return Expanded(
            child: ListView(children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                "Annocument Stream",
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: TW,
            shrinkWrap: true, // 1st add
            physics: ClampingScrollPhysics(),
          ),
        ]));
      },
    );
  }
}

class annocuenttemplate extends StatelessWidget {
  annocuenttemplate({this.description, this.link, this.title, this.date});
  String title;
  String description;
  String link;
  String date;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => news(
                        title: title,
                        description: description,
                        link: link,
                      )));
        },
        color: Colors.white,
        elevation: 10,
        child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 3,
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/anno.png"),
                      fit: BoxFit.contain),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Pluto'),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text("Click Here To Know More",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Pluto')),
                    SizedBox(
                      height: 3,
                    ),
                    Text("Date - ${date}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Pluto')),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_sharp)
            ],
          ),
        ),
      ),
    );
  }
}
