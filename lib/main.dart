import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:partnerr/splashscreen.dart';
import 'package:partnerr/auth_controller.dart';
import 'package:partnerr/login.dart';
import 'package:partnerr/signup.dart';


import 'package:get/get.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',

        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: splashscreen(

        ));
  }
}
