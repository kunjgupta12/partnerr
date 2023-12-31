import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:partnerr/connect_gethelp.dart';
import 'package:partnerr/email_auth.dart';
import 'package:partnerr/login.dart';
import 'package:partnerr/notification_ser.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Stream<QuerySnapshot<Map<String, dynamic>>> notificationStream =

    FirebaseFirestore.instance.collection('rooms').snapshots();
    notificationStream.listen((event) {
      NotificationService()
          .showNotification(title: 'New Call', body: 'Join');

    });

  }


  final firestore = FirebaseFirestore.instance.collection('rooms').snapshots();

  @override
  Widget build(BuildContext context) {
    late User user;
    late String currentUId;
    late String currentEmail;

    user = auth.currentUser!;
    currentUId = user.uid.toString();
    currentEmail = user.email.toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Connect',
          style: TextStyle(
              fontFamily: 'JosefinSans', fontSize: 25, color: Colors.black),
        ),
        centerTitle: true,
        actions: [

          InkWell(

            onTap: () {
             auth.signOut().then(
                (value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Loginpage()));
                },
              );
            },
            child: const Icon(Icons.logout,color: Colors.black,),
          )
        ],
      ),
      body: Column(
        children: [
          Text(user.uid),
          Text(currentEmail),
          //  TextField(controller: _title),
          StreamBuilder<QuerySnapshot>(
              stream: firestore,
              builder:
                  (BuildContext value, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  const CircularProgressIndicator();
                }
                if (snapshot.hasError) return const Text(('Some error'));

                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            horizontalTitleGap: 10,
                            title: TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                      MaterialPageRoute(builder: (context)   => gethelp(room: snapshot.data!.docs[index].id.toString(),)));
                              },
                              child: Text(
                                snapshot.data!.docs[index].id.toString(),
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }),
        ],
      ),
    );
  }
}
