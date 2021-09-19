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
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('young_engineers')
              .doc('young_engineers')
              .collection(widget.day)
              .orderBy('time')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                Text(
                  snapshot.data!.docs.first['theme'].toString().toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      fontSize: 20),
                ),
                SizedBox(height: 25),
                _buildCards(snapshot.data!.docs)
              ],
            );
          }),
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
              color: Theme.of(context).hintColor.withOpacity(0.5),
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
                          color: Theme.of(context).hintColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 23),
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    color: Color(0xfffffaf8),
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (((doc['activity']['title'] ?? []) as List)
                              .isNotEmpty)
                            Column(
                              children:
                                  (doc['activity']['title'] as List).map((e) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        e[0].toString().toUpperCase() +
                                            e.toString().substring(1),
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
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
                                            color: Colors.black54),
                                      ),
                                      Expanded(
                                        child: Text(
                                          e[0].toString().toUpperCase() +
                                              e.toString().substring(1),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w500),
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
                    shadowColor: Theme.of(context).textTheme.bodyText1?.color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  if (((doc['resource_persons'] ?? []) as List).isNotEmpty)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Resource Person(s):',
                          style: TextStyle(
                            fontSize: 15,
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
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
