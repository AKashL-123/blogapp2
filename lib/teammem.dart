import 'package:blog/creatingscreen/createteam.dart';
import 'package:blog/service/fc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class teammem extends StatefulWidget {
  const teammem({Key key}) : super(key: key);

  @override
  _teammemState createState() => _teammemState();
}

class _teammemState extends State<teammem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            " Team Members",
            style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontFamily: 'myralight'),
          ),
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_left_sharp,
              ),
              color: Colors.black,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => createtem()),
                  );
                },
                icon: Icon(
                  Icons.add,
                ),
                color: Colors.black,
              ),
            )
          ],
          backgroundColor: Colors.purple,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessageStream(),
            ],
          ),
        ));
  }
}

class MessageStream extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection("teamname")
          .orderBy('Domain', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.blueAccent,
          ));
        }
        final messages = snapshot.data.docs.reversed;
        List<teamtemplate> TW = [];
        for (var message in messages) {
          final name = message.data()['Name'];
          final imageurl = message.data()['imageurl'];
          final domain = message.data()['Domain'];
          final department = message.data()['Department'];

          final Teamtemplate = teamtemplate(
            imgurl: imageurl,
            department: department,
            domin: domain,
            name: name,
          );
          TW.add(Teamtemplate);
        }
        return Expanded(
            child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: TW,
        ));
      },
    );
  }
}

class teamtemplate extends StatelessWidget {
  teamtemplate({this.imgurl, this.department, this.domin, this.name});
  String imgurl;
  String name;
  String department;
  String domin;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: MaterialButton(
        color: Colors.cyan,
        elevation: 10,
        onPressed: () {  },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: Container(
              height: 90.0,
              width: 70.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(imgurl), fit: BoxFit.cover),
                shape: BoxShape.rectangle,
              ),
            )),
            SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 27,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'lightitalic'),
                    ),
                    Text("Department - $department",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Pluto')),
                    Text("Domain - $domin",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Pluto'))
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
