import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:partnerr/login.dart';

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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/Opening Page background.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          width: w,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: w * .09,
              ),
              Container(
                width: w * 0.35,
                height: h * 0.35,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("img/logo.png"),
                        fit: BoxFit.fitHeight)),
              ),
              Center(
                child: Text(
                  "Serenity",
                  style: TextStyle(
                    fontFamily: "JosefinSans",
                    fontSize: 50,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w600,
                    // color: Color.fromRGBO(10, 10, 3, 0.8)
                  ),
                ),
              ),
              SizedBox(
                height: 120,
              ),
              Row(
                children: [
                  Text(
                    'Enter Your Registered Email-Id',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: w * .04,
              ),
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
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Loginpage();
                      }));
                    },
                    child: Text(
                      "Remember?",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 20,
                          color: Colors.grey[500]),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 80,
              ),
              GestureDetector(
                onTap: () {
                  passwordreset();
                },
                child: Container(
                  width: w * 0.38,
                  height: h * .15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black),
                  child: Center(
                    child: Text(
                      "Reset",
                      style: TextStyle(
                        fontFamily: 'JosefinSans',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
