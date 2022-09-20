import 'package:apwen/drawer.dart';
import 'package:apwen/page_decoration.dart';
import 'package:apwen/screens/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class SocialEvents extends StatefulWidget {
  static const String routeName = '/socialevents';
  SocialEvents({Key? key}) : super(key: key);

  @override
  _SocialEventsState createState() => _SocialEventsState();
}

class _SocialEventsState extends State<SocialEvents> {
  @override
  Widget build(BuildContext context) {
    return PageDecoration(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('social_events')
              .orderBy('id')
              .snapshots(),
          builder: (context, snapshot) {
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
                  'No Events',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                  ),
                ),
              );
            }

            return ListView.builder(
              itemBuilder: (context, index) {
                QueryDocumentSnapshot currentData = snapshot.data!.docs[index];
                return TimelineTile(
                  node: TimelineNode.simple(
                    indicatorPosition: 0,
                    color: Color.fromRGBO(255, 148, 237, 1),
                    indicatorSize: 17,
                  ),
                  contents: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            currentData['date'],
                            style: TextStyle(
                              color: Color.fromRGBO(165, 54, 146, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 16.5,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Card(
                          color: Color.fromRGBO(227, 207, 224, 1),
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentData['full_date'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  currentData['name'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '@${currentData['venue']}',
                                        style: TextStyle(
                                          fontSize: 14.5,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: 80,
                                      child: Text(
                                        currentData['time'],
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(165, 54, 146, 1),
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          shadowColor: Color.fromRGBO(198, 162, 192, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                              side: BorderSide(
                                color: Colors.white,
                                width: 1,
                              )),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                  nodeAlign: TimelineNodeAlign.start,
                );
              },
              itemCount: snapshot.data!.docs.length,
              padding: EdgeInsets.symmetric(vertical: 30),
            );
          },
        ),
      ),
      pageHeader: 'Social Events',
    );
  }
}
