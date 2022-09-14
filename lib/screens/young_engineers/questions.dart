import 'package:apwen/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class Questions extends StatefulWidget {
  static const String routeName = '/questions';
  Questions({Key? key}) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  Future<void> openUrl(String url, BuildContext context) async {
    if (await canLaunchUrl(Uri.parse(url)))
      launchUrl(Uri.parse(url));
    else
      showError(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 5, top: 5),
          child: RichText(
            text: TextSpan(
              style:
                  Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 21),
              children: [
                TextSpan(text: 'Q'),
                TextSpan(
                  text: '&',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                TextSpan(text: 'A'),
              ],
            ),
          ),
        ),
        elevation: 1,
        toolbarHeight: 65,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
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
                child: CircularProgressIndicator(),
              );
            if (!(snapshot.hasData) || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'No Available Links',
                  style: TextStyle(color: Colors.black),
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
                            fontSize: 20,
                            color: Color(0xFF1C293D),
                            fontWeight: FontWeight.w500),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () async {
                        String link = doc['link'] ?? '';
                        bool active = doc['active'] ?? true;

                        if (link.isNotEmpty && active)
                          openUrl(link, context);
                        else
                          Fluttertoast.showToast(
                              msg: 'Link not yet active',
                              backgroundColor: Color(0xFF1C293D),
                              textColor: Colors.white,
                              toastLength: Toast.LENGTH_LONG);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Divider(
                        color: Colors.black,
                      ),
                    )
                  ],
                );
              },
              itemCount: snapshot.data!.docs.length,
            );
          },
        ),
      ),
    );
  }
}
