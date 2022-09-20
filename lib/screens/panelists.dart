import 'package:apwen/page_decoration.dart';
import 'package:apwen/screens/topics_speakers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Panelists extends StatefulWidget {
  static const String routeName = '/panelists';
  Panelists({Key? key}) : super(key: key);

  @override
  State<Panelists> createState() => _PanelistsState();
}

class _PanelistsState extends State<Panelists> {
  @override
  Widget build(BuildContext context) {
    return PageDecoration(
      pageHeader: 'Panelists',
      showMenu: true,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Panelists')
            .orderBy('id')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  Color.fromRGBO(165, 54, 146, 1),
                ),
                strokeWidth: 5,
              ),
            );
          if (!(snapshot.hasData) || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No Data',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                ),
              ),
            );
          }

          return buildSpeakers(snapshot.requireData.docs, context);
        },
      ),
    );
  }
}
