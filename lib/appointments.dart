import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class appointments extends StatefulWidget {
  const appointments({super.key});

  @override
  State<appointments> createState() => _appointmentsState();
}

class _appointmentsState extends State<appointments> {
  final profileList =
  FirebaseFirestore.instance.collection('doctor details').doc('785885').collection('bookings');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: profileList.doc('ehUln6WUhylbiOUqba0J').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }


        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Center(child: Text(" ${data['date']} "));
        }

        return Text("loading");
      },
    );
  }}