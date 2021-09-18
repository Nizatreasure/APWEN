import 'package:apwen/screens/topic_brief.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  static const routeName = '/comments';
  final int id;
  Comments({Key? key, required this.id}) : super(key: key);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        elevation: 0,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Comments')
              .doc('Comments')
              .collection(widget.id.toString())
              .orderBy('timestamp', descending: true)
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
                  'No comments',
                  style: TextStyle(color: Colors.black),
                ),
              );
            }
            return _buildComments(snapshot.requireData.docs);
          }),
    );
  }

  _buildComments(List<QueryDocumentSnapshot> data) {
    return ListView.builder(
        itemBuilder: (context, index) {
          var doc = data[index].data()! as Map<String, dynamic>;
          String time = '';

          DateTime messageDate = doc['timestamp'].toDate();
          DateTime currentDate = DateTime.now();
          if (messageDate.year == currentDate.year &&
              messageDate.month == currentDate.month &&
              messageDate.day == currentDate.day) {
            int hour = messageDate.hour;
            int min = messageDate.minute;
            String val = '';

            if (hour > 12) {
              hour = (hour - 12);
              val = 'pm';
            } else
              val = 'am';

            time = 'Today, ' + hour.toString() + ':' + min.toString() + ' $val';
          } else {
            time = messageDate.day.toString() +
                '/' +
                messageDate.month.toString() +
                '/' +
                messageDate.year.toString();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (index == 0) SizedBox(height: 20),
              Card(
                elevation: 2,
                shadowColor: Colors.black,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            doc['name'] ?? 'Guest',
                          ),
                          Text(
                            time,
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        doc['message'] ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Montserrat'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        itemCount: data.length);
  }
}
