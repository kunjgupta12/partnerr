import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partnerr/connect_gethelp.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final firestore = FirebaseFirestore.instance.collection('rooms').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join'),
          actions: [
          InkWell(
          onTap: () {
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => gethelp()));
    },
        child: Icon(Icons.add)),],
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: firestore,
              builder:
                  (BuildContext value, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator();
                if (snapshot.hasError) return Text(('Some error'));

                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            horizontalTitleGap: 10,
                            title: SelectableText(
                              snapshot.data!.docs[index].id.toString(),
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }),
        ],
      ),
    );
  }
}
