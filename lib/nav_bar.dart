import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partnerr/appointments.dart';
import 'package:partnerr/homepage.dart';

class profilepage extends StatefulWidget {
  const profilepage({super.key});

  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  int index = 0;
  final screens = [
    homepage(),
    appointments(),
    //  SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.blueGrey,
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        child: NavigationBar(
          height: 60,
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.chat,
              ),
              label: 'Rooms',
            ),
            NavigationDestination(
              icon: Icon(Icons.help),
              label: 'Appointments',
            ),

            /*  NavigationDestination(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),*/
          ],
        ),
      ),
    );
  }
}
