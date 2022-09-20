import 'package:apwen/drawer.dart';
import 'package:apwen/page_decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Questions extends StatefulWidget {
  static const String routeName = '/questions';
  Questions({Key? key}) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  @override
  Widget build(BuildContext context) {
    return PageDecoration(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('questions')
              .orderBy('id')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            return ListView.builder(
              itemBuilder: (context, index) {
                Map doc =
                    snapshot.data!.docs[index].data()! as Map<String, dynamic>;
                return Column(
                  children: [
                    if (index == 0) SizedBox(height: 20),
                    ListTile(
                      title: Text(
                        doc['name'] ?? 'Link $index',
                        style: TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Color.fromRGBO(165, 54, 146, 1),
                      ),
                      onTap: () async {
                        String link = doc['link'] ?? '';
                        bool active = doc['active'] ?? false;

                        if (link.isNotEmpty && active)
                          openUrl(link, context);
                        else
                          Fluttertoast.showToast(
                              msg: 'Link not yet active',
                              backgroundColor: Color.fromRGBO(165, 54, 146, 1),
                              textColor: Colors.white,
                              toastLength: Toast.LENGTH_LONG);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Divider(
                        color: Color.fromRGBO(165, 54, 146, 1),
                      ),
                    )
                  ],
                );
              },
              itemCount: snapshot.data!.docs.length,
            );
          }),
      pageHeader: 'Q&A',
    );
  }
}
