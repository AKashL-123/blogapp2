import 'dart:ui';

import 'package:blog/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_home';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AssetImage image;

  bool loading = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    image = const AssetImage("assets/welcomescreen.png");
  }

  Future<void> signup(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      setState(() {
        loading = true;
      });
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        // Getting users credential
        UserCredential result = await auth.signInWithCredential(authCredential);
        User user = result.user;
        setState(() {
          loading = false;
        });
        if (result != null) {
          Fluttertoast.showToast(
            msg: "Login Successfull",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => homescreen()));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    image.evict();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
            inAsyncCall: loading,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(image: image, fit: BoxFit.contain)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Hey !",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Montserrat'),
                        ),
                      ),Text("Welcome",style:TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.w500,fontFamily: 'Montserrat'),)
                      ,Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.w500,fontFamily:'Montserrat',)
                        ),
                          ],
                  ),
                  Center(
                    child: SizedBox(
                      height: 20,
                      width: 290,
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                  ),
                          Center(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 15.0, bottom: 10, top: 0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              loading = true;
                            });
                            signup(context);
                          },
                          child: Card(
                              color: Colors.blue,
                              margin: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 30),
                              child: ListTile(
                                leading: Image.asset(
                                  "assets/google.png",
                                  height: 35,
                                ),
                                title: Text(
                                  "SignIn With Google",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              )),
                        ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(50, 8, 50, 8),
                        child: SizedBox(
                          child: Image.asset(
                            "assets/instagram.png",
                            height: 20,
                          ),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.teal,
                        onSurface: Colors.yellow,
                        side: BorderSide(color: Colors.grey, width: 2),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                      ),
                      onPressed: () async {},
                    ),
                    TextButton(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(50, 8, 50, 8),
                        child: SizedBox(
                          child: Image.asset(
                            "assets/link.jpg",
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.teal,
                        onSurface: Colors.yellow,
                        side: BorderSide(color: Colors.grey, width: 2),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                      ),
                      onPressed: () async {},
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 30, 30),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "By continue you agree hyperstream's Terms of ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          "Service & Privacy Policy",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                )
              ],
                
                // children: <Widget>[
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: <Widget>[
                //       // ignore: deprecated_member_use

                //     ],
                //   ),
                //   SizedBox(
                //     height: 48.0,
                //   ),
                //   Column(
                //     children: [
                //       Container(
                //         width: 300,
                //         height: 300,
                //         decoration: BoxDecoration(
                //             shape: BoxShape.circle,
                //             image: DecorationImage(image: image)),
                //       )
                //     ],
                //   ),
                //   SizedBox(
                //     height: 50,
                //   ),
                //   Padding(
                //     padding: const EdgeInsets.only(left: 20, right: 20),
                //     child: MaterialButton(
                //       color: Colors.purpleAccent,
                //       elevation: 10,
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Container(
                //             height: 50.0,
                //             width: 30.0,
                //             decoration: BoxDecoration(
                //               image: DecorationImage(
                //                   image: AssetImage('assets/google.png'),
                //                   fit: BoxFit.cover),
                //               shape: BoxShape.circle,
                //             ),
                //           ),
                //           SizedBox(
                //             width: 20,
                //           ),
                //           Text(
                //             "Sign in with google",
                //             style: TextStyle(
                //                 fontSize: 15,
                //                 fontWeight: FontWeight.w900,
                //                 fontFamily: 'Montserrat'),
                //           )
                //         ],
                //       ),
                //             onPressed: () {
                //               setState(() {
                //                 signup(context);
                //               });
                //             },
                //           ),
                //         ),
                //       ],
              ),
            )));
  }
}
