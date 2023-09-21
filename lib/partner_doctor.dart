import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partnerr/user_details.dart';

import 'doctor_details.dart';

class partnerordoctor extends StatefulWidget {
  const partnerordoctor({super.key});

  @override
  State<partnerordoctor> createState() => _partnerordoctorState();
}

class _partnerordoctorState extends State<partnerordoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 60),
            child: Container(
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => doctordetails(),
                    ),
                  );
                },
                child: Text(
                  'Doctor',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)))),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => userdetails(),
                ),
              );
            },
            child: Text(
              'Partner',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
