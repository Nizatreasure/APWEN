import 'package:apwen/page_decoration.dart';
import 'package:apwen/screens/topics_speakers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class YoungEngineersSpeakers extends StatelessWidget {
  static const String routeName = '/youngengineersspeakers';
  YoungEngineersSpeakers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageDecoration(
      pageHeader: 'YE Speakers',
      showMenu: false,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('young_engineer_speakers')
            .orderBy('name')
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

          return buildSpeakers(snapshot.data!.docs, context);
        },
      ),
    );
  }
}
