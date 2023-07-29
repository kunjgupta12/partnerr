import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:partnerr/auth_controller.dart';
import 'package:partnerr/signup.dart';

import 'package:partnerr/Forgotpassword.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final emailController = TextEditingController();
  var passwordcontroller = TextEditingController();
  // bool passToggle = true;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: w * 0.5,
              height: h * 0.4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("img/logo.png"),
                      fit: BoxFit.fitHeight)),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hey Partner",
                    style: TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(10, 10, 3, 0.8)),
                  ),
                  Text(
                    "Sign into your Account",
                    style: TextStyle(fontSize: 20, color: Colors.grey[500]),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1, 1),
                              color: Colors.grey.withOpacity(.2))
                        ]),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.deepOrangeAccent,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1, 1),
                              color: Colors.grey.withOpacity(.2))
                        ]),
                    child: TextFormField(
                      controller: passwordcontroller,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.deepOrangeAccent,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ForgotPasswordPage();
                          }));
                        },
                        child: Text(
                          "Forgot Your Password?",
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[500]),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60,
            ),
            GestureDetector(
              onTap: () {
                AuthController.instance.login(emailController.text.trim(),
                    passwordcontroller.text.trim());
              },
              child: Container(
                width: w * 0.38,
                height: h * .15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        image: AssetImage("img/logo0.png"), fit: BoxFit.fill)),
                child: Center(
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ),
            RichText(
                text: TextSpan(
                    text: "Don\'t have an account?",
                    style: TextStyle(color: Colors.grey[500], fontSize: 20),
                    children: [
                  TextSpan(
                      text: "Create one for Free!!",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(() => SignupPage()))
                ]))
          ],
        ),
      ),
    );
  }
}
