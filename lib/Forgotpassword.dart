import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailcontroller = TextEditingController();
  @override
  void dispose() {
    _emailcontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future passwordreset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailcontroller.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.blueGrey,
              content: Text(
                'Password resend link has been send !'
                '                             Please Check  your Email',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white12,
              content: Text(
                e.message.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: w * 0.5,
              height: h * 0.45,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("img/logo.png"),
                      fit: BoxFit.fitHeight)),
            ),
            Text(
              'Enter Your Registered Email-Id a Resend Link Will be Send',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 150),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: Offset(1, 1),
                        color: Colors.grey.withOpacity(.2))
                  ]),
              child: TextField(
                controller: _emailcontroller,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.deepOrangeAccent,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.white12, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 80),
            MaterialButton(
              onPressed: passwordreset,
              shape: Border.symmetric(),
              child: Text(
                'Resend password',
                style: TextStyle(
                  fontSize: 30,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                ),
              ),
              color: Colors.white10,
            ),
          ],
        ),
      ),
    );
  }
}
