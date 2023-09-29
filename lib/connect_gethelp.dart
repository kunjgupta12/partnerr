import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:partnerr/splashscreen.dart';

import 'join_vc.dart';

TextEditingController _title = TextEditingController();
final TextEditingController _desc = TextEditingController();
String? roomId;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 // runApp(gethelp(room: ""));
}




class gethelp extends StatefulWidget {
  String room;
  gethelp({required this.room,Key? key}) : super(key: key);

  @override
  _gethelpState createState() => _gethelpState();
}

class _gethelpState extends State<gethelp> {
  //var roomId = roomRef.id;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User user;
  late String currentUId;
  late String currentEmail;
  Signaling signaling = Signaling();
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
 // TextEditingController textEditingController = TextEditingController(text: widget.room.toString());

  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();
    user = auth.currentUser!;

    currentUId = user.uid.toString();
    signaling.openUserMedia(_localRenderer, _remoteRenderer);
    signaling.onAddRemoteStream = ((stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });}
  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController(text: widget.room.toString());

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  signaling.openUserMedia(_localRenderer, _remoteRenderer);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black87),
                ),
                child: Text(
                  "Open camera & microphone",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () async {
                  roomId = await signaling.createRoom(_remoteRenderer);
                  textEditingController.text = roomId!;
                  setState(() {});
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black87),
                ),
                child: Text(
                  "Create room",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  // Add roomId
                  signaling.joinRoom(
                    widget.room.trim().toString(),
                   // textEditingController.text.trim(),
                    _remoteRenderer,
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black87),
                ),
                child: Text(
                  "Join room",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  signaling.hangUp(_localRenderer);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black87),
                ),
                child: Text(
                  "Hangup",
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
          SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: RTCVideoView(_localRenderer, mirror: true)),
                  Expanded(child: RTCVideoView(_remoteRenderer)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              //  Text(widget.room),
              /*  Flexible(
                  child: TextFormField(
                    controller: textEditingController       ),
                )*/
              ],
            ),
          ),
          SizedBox(height: 8)
        ],
      ),
    );
  }
}
