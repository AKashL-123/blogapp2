import 'package:cloud_firestore/cloud_firestore.dart';

class fcstore {
  Future<void> adddata(teamdata) async {
    FirebaseFirestore.instance
        .collection("teamname")
        .add(teamdata)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> addphotodata(photodata) async {
    FirebaseFirestore.instance
        .collection("photowall")
        .add(photodata)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> addannocument(annocumentdata) async {
    FirebaseFirestore.instance
        .collection("annocument")
        .add(annocumentdata)
        .catchError((e) {
      print(e);
    });
  }
}
