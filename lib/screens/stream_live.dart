import 'package:apwen/drawer.dart';
import 'package:apwen/page_decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class StreamLive extends StatefulWidget {
  static const String routeName = '/streamlive';
  StreamLive({Key? key}) : super(key: key);

  @override
  _StreamLiveState createState() => _StreamLiveState();
}

class _StreamLiveState extends State<StreamLive> {
  @override
  Widget build(BuildContext context) {
    return PageDecoration(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('stream_live')
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
                'No Available Links. \nPlease Check Back Later.',
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
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    leading: Icon(
                      FontAwesomeIcons.link,
                      size: 20,
                      color: Color.fromRGBO(165, 54, 146, 1),
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
                          toastLength: Toast.LENGTH_LONG,
                        );
                    },
                  ),
                  // if (index != snapshot.data!.docs.length - 1)
                  Padding(
                    padding: EdgeInsets.only(left: 65, right: 10),
                    child: Divider(
                      color: Color.fromRGBO(165, 54, 146, 1),
                    ),
                  )
                ],
              );
            },
            itemCount: snapshot.data!.docs.length,
          );
        },
      ),
      pageHeader: 'Stream Live',
    );
  }
}
