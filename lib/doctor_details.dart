import 'dart:io';
import 'button_widget.dart';
import 'firebase_api.dart';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:../flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:partnerr/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

String? validateEmail(String? value) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);

  return value!.isNotEmpty && !regex.hasMatch(value)
      ? 'Enter a valid email address'
      : null;
}

String? validatemobile(String value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return 'Please enter mobile number';
  } else if (!regExp.hasMatch(value)) {
    return 'Please enter valid mobile number';
  }
  return null;
}

class doctordetails extends StatefulWidget {
  doctordetails({super.key});

  @override
  State<doctordetails> createState() => _doctordetailsState();
}

class _doctordetailsState extends State<doctordetails> {
  UploadTask? task;

  File? file;

  final mobilecontroller = TextEditingController();

  final emailcontroller = TextEditingController();

  final namecontroller = TextEditingController();

  final registraioncontroller = TextEditingController();

  final pricecontroller = TextEditingController();

  final exp = TextEditingController();

  final study = TextEditingController();

  bool isButtonClickable = true;

  @override
  Widget build(BuildContext context) {
    String imageUrl = '';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Details',
          style: TextStyle(
              fontFamily: 'JosefinSans', fontSize: 25, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/Opening Page background.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                // SizedBox(height: 20),
                task != null ? buildUploadStatus(task!) : Container(),
                ButtonWidget(
                  text: 'Select File',
                  icon: Icons.attach_file,
                  onClicked: selectFile,
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
                    controller: namecontroller,
                    decoration: InputDecoration(
                        hintText: 'Full Name',
                        prefixIcon: Icon(
                          Icons.person,
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
                    controller: emailcontroller,
                    autovalidateMode: AutovalidateMode.always,
                    validator: validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'Email Address',
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
                  height: 20,
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
                    controller: mobilecontroller,
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Contact number',
                        prefixIcon: Icon(
                          Icons.phone,
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
                    controller: exp,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                        hintText: 'Experience',
                        prefixIcon: Icon(
                          Icons.account_box_rounded,
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
                    controller: study,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                        hintText: 'Degree',
                        prefixIcon: Icon(
                          Icons.school,
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
                    controller: registraioncontroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Registraion number',
                        prefixIcon: Icon(
                          Icons.numbers,
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
                    controller: pricecontroller,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'price for 1 hour',
                        prefixIcon: Icon(
                          Icons.currency_rupee,
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
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)))),
                  onPressed: () {
                    uploadFile();
                    /*   final height = double.parse(pricecontroller.text) ;
                    String pricee = height.toString();
                    CollectionReference collref =
                        FirebaseFirestore.instance.collection('doctor details');
                    collref.doc(registraioncontroller.text).set({
                      'name': namecontroller.text,
                      'email': emailcontroller.text,
                      'mobile': mobilecontroller.text,
                      'registraionnumber': registraioncontroller.text,
                      'Experience': exp.text,
                      'Degree': study.text,
                      'price': pricee,
                      'image':''

                    });*/
                    if (namecontroller.text != "" &&
                        emailcontroller.text != "" &&
                        mobilecontroller.text != "" &&
                        registraioncontroller.text != "") {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => homepage(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;
    final height = double.parse(pricecontroller.text);
    String pricee = height.toString();
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    CollectionReference collref =
        FirebaseFirestore.instance.collection('doctor details');
    collref.doc(registraioncontroller.text).set({
      'image': urlDownload,
      'name': namecontroller.text,
      'email': emailcontroller.text,
      'mobile': mobilecontroller.text,
      'registraionnumber': registraioncontroller.text,
      'Experience': exp.text,
      'Degree': study.text,
      'price': pricee,
    });
    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
