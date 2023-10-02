import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class appointments extends StatefulWidget {
  const appointments({super.key});

  @override
  State<appointments> createState() => _appointmentsState();
}

class _appointmentsState extends State<appointments> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    late User user;
    late String currentUId;
    late String currentEmail;
    late String number;
    user = auth.currentUser!;
    Stream<List<DocumentSnapshot>> getAllDocuments() {
      return FirebaseFirestore.instance.collection('doctor details').doc(
          user.email).collection('booking').snapshots().map(
            (QuerySnapshot querySnapshot) => querySnapshot.docs,
      );
    }

    final profileList =
    FirebaseFirestore.instance.collection('doctor details')
        .doc(user.email)
        .collection('booking')
        .doc();

    return StreamBuilder<List<DocumentSnapshot>>(
      stream: getAllDocuments(),
      builder: (BuildContext context,
          AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        List<DocumentSnapshot> documents = snapshot.data!;
        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(documents[index]['time']),
              subtitle: Text(documents[index]['date']),
            );
          },
        );
      },
    );}}
