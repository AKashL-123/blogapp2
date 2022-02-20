import 'package:blog/chat_screen.dart';
import 'package:blog/maindrawer.dart';
import 'package:blog/menubarscreen/annocumentscreen.dart';
import 'package:blog/menubarscreen/blogscreen.dart';
import 'package:blog/menubarscreen/homescreen.dart';
import 'package:blog/menubarscreen/photowall.dart';
import 'package:blog/service/slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:blog/service/slider.dart';
import 'package:blog/menubarscreen/homescreen.dart';

var option = 1;

class homescreen extends StatefulWidget {
  var emaildetail;
  homescreen({this.emaildetail});

  @override
  _homescreenState createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
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

  void ontaped(int index) {
    try {
      setState(() {
        selectedindex = index;
      });
      pagecontroller.jumpToPage(index);
    } catch (e) {
      print(e);
    }
  }

  int selectedindex = 0;
  PageController pagecontroller = PageController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Color(0xfff8faf8),
          centerTitle: true,
          elevation: 1,
          title: SizedBox(
            child: Text(
              "MLSA COMMUNITY",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen()),
                  );
                },
                icon: Icon(
                  Icons.arrow_right,
                ),
                color: Colors.black,
              ),
            )
          ],
        ),
        drawer: Maindrawer(),
        body: PageView(
          controller: pagecontroller,
          onPageChanged: (page) {
            setState(() {
              selectedindex = page;
            });
          },
          children: [
            homescreen1(),
            blogscreen(),
            annocumentscreen(),
            photowallscreen()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.note,
                ),
                label: "Blog"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_today,
                ),
                label: "News"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.photo_album,
                ),
                label: "Photo")
          ],
          currentIndex: selectedindex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: ontaped,
        ),
      );
    } catch (e) {
      print(e);
      
    }
  }
}
