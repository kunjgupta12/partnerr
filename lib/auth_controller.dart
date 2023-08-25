import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:partnerr/email_authregister.dart';
import 'package:partnerr/homepage.dart';

import 'package:partnerr/login.dart';
import 'package:partnerr/email_authstep.dart';
import 'package:partnerr/partner_doctor.dart';
import 'package:partnerr/signup.dart';
import 'package:partnerr/user_details.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool k = false;
  bool isEmailVerified = false;
  late User user;
  late String currentUId;
  late String currentEmail;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    //notified
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print("login page");
      Get.offAll(() => Loginpage());
    }
  }
/*
  void checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;


    Get.offAll(() => partnerordoctor());
  }*/

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.offAll(() => EmailVerificationScreenregister());
      user = auth.currentUser!;

      CollectionReference collref =
          FirebaseFirestore.instance.collection('Users');

      collref.add({
        'password': password,
        'email': email,
        'uid': user.uid.toString(),
      });
    } catch (e) {
      Get.snackbar(
        "About user",
        "User message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Account creation failed",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      //Get.offAll(() => homepage());
      if (isEmailVerified) {
        Get.offAll(homepage());
      } else {
        Get.offAll(EmailVerificationScreen());
      }
    } catch (e) {
      Get.snackbar(
        "About Login",
        "Login message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Login  failed",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  void Logout() async {
    await auth.signOut();
  }
}
