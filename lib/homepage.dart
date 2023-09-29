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
  notifications notification = notifications();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notification.initializeSettings();
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

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
        title: Text(
          'Connect',
          style: TextStyle(
              fontFamily: 'JosefinSans', fontSize: 25, color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          InkWell(
              onTap: () {
                notification.scheduledNotification(
                    "Scheduled Notification", "It was Triggered 1 Min ago");

                print('Notification should poped');
              //  Navigator.push(context,
                //    MaterialPageRoute(builder: (context) => gethelp()));
              },
              child: Icon(Icons.add)),
          SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () {
              auth.signOut().then(
                (value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Loginpage()));
                },
              );
            },
            child: Icon(Icons.logout),
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
                if (snapshot.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator();
                if (snapshot.hasError) return Text(('Some error'));

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
