import 'package:apwen/drawer.dart';
import 'package:apwen/page_decoration.dart';
import 'package:apwen/screens/home_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Sponsors extends StatefulWidget {
  static const routeName = '/sponsors';
  Sponsors({Key? key}) : super(key: key);

  @override
  _SponsorsState createState() => _SponsorsState();
}

class _SponsorsState extends State<Sponsors> {
  @override
  Widget build(BuildContext context) {
    return PageDecoration(
      showMenu: true,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('sponsors')
              .orderBy('id')
              .snapshots(),
          builder: (BuildContext context, snapshot) {
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
                  'No Sponsors Available.',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                padding: EdgeInsets.all(20),
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot currentData =
                      snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {
                      launchWebsite(currentData);
                    },
                    child: Container(
                      constraints: BoxConstraints(minHeight: 200),
                      child: CachedNetworkImage(
                        imageUrl: currentData['image'],
                      ),
                    ),
                  );
                });
          }),
      pageHeader: 'APWEN Sponsors',
    );
  }
}

Future<void> launchWebsite(QueryDocumentSnapshot data) async {
  String url = data['url'] ?? '';
  if (url.isNotEmpty && await canLaunchUrl(Uri.parse(url))) {
    launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }
}
