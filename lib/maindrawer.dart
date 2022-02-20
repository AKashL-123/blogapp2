import 'package:blog/alert.dart';
import 'package:blog/chat_screen.dart';
import 'package:blog/creatingscreen/annocument.dart';
import 'package:blog/creatingscreen/createblog.dart';
import 'package:blog/creatingscreen/photouploadscreen.dart';
import 'package:blog/menubarscreen/annocumentscreen.dart';
import 'package:blog/teammem.dart';
import 'package:blog/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Maindrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [myheaddrawr(), mydrawerlist()],
          ),
        ),
      ),
    );
  }
}

class myheaddrawr extends StatefulWidget {
  @override
  _myheaddrawrState createState() => _myheaddrawrState();
}

class _myheaddrawrState extends State<myheaddrawr> {
  @override
  Future<void> initState() {
    getcurrentuser();
    getprofileimage();
    super.initState();
  }

  var profilepic;
  getprofileimage() {
    if (_auth.currentUser.photoURL != null) {
      profilepic = NetworkImage(_auth.currentUser.photoURL);
    } else {
      profilepic = AssetImage("assets/user.png");
    }
  }

  final _auth = FirebaseAuth.instance;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: profilepic,
                )),
          ),
          Text("${userdetails.toString().split('@')[0]}",
              style: TextStyle(fontSize: 20, color: Colors.white)),
        ],
      ),
    );
  }
}

class mydrawerlist extends StatelessWidget {
  final textFieldController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  // Future<void> keeplogin(emailvalue) async {
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setString('email', emailvalue);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          menuitem(
            icon: Icon(
              Icons.clear_all,
              size: 25,
              color: Colors.black,
            ),
            title: "Clear Chat",
            ontap: () async {
              var collection = FirebaseFirestore.instance.collection('message');
              var snapshots = await collection.get();
              for (var doc in snapshots.docs) {
                await doc.reference.delete();
              }
            },
          ),
          menuitem(
            icon: Icon(
              Icons.home_filled,
            ),
            title: "Team List",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => teammem()),
              );
            },
          ),
          menuitem(
            icon: Icon(
              Icons.travel_explore,
            ),
            title: "Create New Blog",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => createblog()),
              );
            },
          ),
          menuitem(
            icon: Icon(
              Icons.photo_album,
            ),
            title: "Upload New Photo",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => createphotoscreen()),
              );
            },
          ),
          menuitem(
            icon: Icon(Icons.perm_device_information),
            title: "Post New Annocument",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => createannocument()),
              );
            },
          ),
          menuitem(
            icon: Icon(Icons.verified_user),
            title: "Suggestion",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Alert()),
              );
            },
          ),
          menuitem(
            icon: Icon(
              Icons.logout,
            ),
            title: "Logout",
            ontap: () {

              _auth.signOut();

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()));
            },
          ),
        ]),
    );

            
  }
}

class menuitem extends StatelessWidget {
  menuitem({this.ontap, this.icon, this.title});
  final VoidCallback ontap;
  final Icon icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: GestureDetector(
            onTap: ontap,
            child: Row(
              children: [
                Expanded(child: icon),
                Expanded(
                    flex: 3,
                    child: Text(
                      title,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// class Alert extends StatelessWidget {
//   Future showdialog(BuildContext context,String message) async{
//     return showDialog(context: context, builder: new AlertDialog(
//       title: Text(message),
//       actions: <Widget>[
//         new 
//       ],
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }
