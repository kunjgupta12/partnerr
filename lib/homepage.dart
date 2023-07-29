import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:partnerr/connect_gethelp.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final firestore = FirebaseFirestore.instance.collection('rooms').snapshots();
  @override
  void initState() {
    super.initState();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      macOS: null,
      linux: null,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse:
            (NotificationResponse notifiationresponse) {
      switch (notifiationresponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          break;
        case NotificationResponseType.selectedNotificationAction:
          break;
      }
      // onSelectNotification: (dataYouNeedToUseWhenNotificationIsClicked) {},
    });
    Stream<QuerySnapshot<Map<String, dynamic>>> notificationStream =
        FirebaseFirestore.instance.collection('rooms').snapshots();
    notificationStream.listen((event) {
      if (event.docs.isEmpty) {
        return;
      }
      showNotification(event.docs.first);
    });
  }

  void showNotification(QueryDocumentSnapshot<Map<String, dynamic>> event) {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('001', 'Local Notification',
            channelDescription: 'to send local notification');
    const NotificationDetails details =
        NotificationDetails(android: androidNotificationDetails);
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      linux: null,
    );

    flutterLocalNotificationsPlugin.show(
        01, _title.text, _desc.text, notificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join'),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => gethelp()));
              },
              child: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
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
                            title: SelectableText(
                              snapshot.data!.docs[index].id.toString(),
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 20,
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
