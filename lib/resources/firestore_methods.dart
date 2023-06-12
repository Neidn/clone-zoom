import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/utils/constants.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> get meetingHistoryStream =>
      _firestore
          .collection(usersPath)
          .doc(_auth.currentUser!.uid)
          .collection(meetingsPath)
          .orderBy('createdAt', descending: true)
          .snapshots();

  void addToMeetingHistory(String meetingName) async {
    try {
      await _firestore
          .collection(usersPath)
          .doc(_auth.currentUser!.uid)
          .collection(meetingsPath)
          .add({
        'meetingName': meetingName,
        'createdAt': DateTime.now(),
      });
    } catch (e) {
      print(e);
    }
  }
}
