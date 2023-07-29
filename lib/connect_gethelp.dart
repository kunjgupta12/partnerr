import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'join_vc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(gethelp());
}

class gethelp extends StatefulWidget {
  const gethelp({super.key});

  @override
  State<gethelp> createState() => _gethelpState();
}

class _gethelpState extends State<gethelp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Signaling signaling = Signaling();
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roomId;
  TextEditingController textEditingController = TextEditingController(text: '');

  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();

    signaling.onAddRemoteStream = ((stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    textEditingController.text.trim(),
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
                Text("Join the following Room: "),
                Flexible(
                  child: TextFormField(
                    controller: textEditingController,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 8)
        ],
      ),
    );
  }
}
