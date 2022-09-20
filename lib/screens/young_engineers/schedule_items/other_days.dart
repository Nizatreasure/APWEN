import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class OtherDays extends StatefulWidget {
  final String day;
  OtherDays(this.day, {Key? key}) : super(key: key);

  @override
  _OtherDaysState createState() => _OtherDaysState();
}

class _OtherDaysState extends State<OtherDays> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 20),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('young_engineers')
            .doc(widget.day)
            .collection(widget.day)
            .orderBy('time')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (!(snapshot.hasData) || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No programme',
                style: TextStyle(color: Colors.black),
              ),
            );
          }

          return ListView(
            children: [
              SizedBox(height: 20),
              if (snapshot.data!.docs.first['theme'].toString().isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Text(
                    snapshot.data!.docs.first['theme'].toString().toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      fontSize: 16.5,
                    ),
                  ),
                ),
              _buildCards(snapshot.data!.docs)
            ],
          );
        },
      ),
    );
  }

  _buildCards(List<QueryDocumentSnapshot> data) {
    return ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          Map doc = data[index].data()! as Map<String, dynamic>;

          return TimelineTile(
            node: TimelineNode.simple(
              indicatorPosition: 0,
              color: Color.fromRGBO(165, 54, 146, 1),
              indicatorSize: 17,
            ),
            contents: Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      doc['time'],
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
                      padding: const EdgeInsets.fromLTRB(22, 15, 15, 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (((doc['activity']['title'] ?? []) as List)
                              .isNotEmpty)
                            Column(
                              children:
                                  (doc['activity']['title'] as List).map((e) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          e[0].toString().toUpperCase() +
                                              e.toString().substring(1),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          if (((doc['activity']['others'] ?? []) as List)
                                  .isNotEmpty &&
                              ((doc['activity']['title'] ?? []) as List)
                                  .isNotEmpty)
                            SizedBox(height: 12),
                          if (((doc['activity']['others'] ?? []) as List)
                              .isNotEmpty)
                            Column(
                              children:
                                  (doc['activity']['others'] as List).map((e) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 10,
                                        width: 6,
                                        margin:
                                            EdgeInsets.only(right: 8, top: 4),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Color.fromRGBO(165, 54, 146, 1),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          e[0].toString().toUpperCase() +
                                              e.toString().substring(1),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    ),
                    shadowColor: Color.fromRGBO(198, 162, 192, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                      side: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                  ),
                  if (((doc['venue'] ?? '') as String).isNotEmpty)
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 4.0, top: 6, bottom: 8),
                          child: Text(
                            'Venue:',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            doc['venue'],
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (((doc['resource_persons'] ?? []) as List).isNotEmpty)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 5),
                        Text(
                          'Resource Person(s):',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: (doc['resource_persons'] as List)
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(bottom: 3.0),
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        )
                      ],
                    ),
                  SizedBox(height: 8),
                  if (((doc['moderators'] ?? []) as List).isNotEmpty)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Moderator(s):',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: (doc['moderators'] as List)
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(bottom: 3.0),
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        )
                      ],
                    )
                ],
              ),
            ),
            nodeAlign: TimelineNodeAlign.start,
          );
        },
        itemCount: data.length);
  }
}
