import 'package:apwen/page_decoration.dart';
import 'package:apwen/screens/about_speakers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TopicsSpeakers extends StatefulWidget {
  static const routeName = '/topicsandspeakers';
  TopicsSpeakers({Key? key}) : super(key: key);

  @override
  _TopicsSpeakersState createState() => _TopicsSpeakersState();
}

class _TopicsSpeakersState extends State<TopicsSpeakers> {
  @override
  Widget build(BuildContext context) {
    return PageDecoration(
      pageHeader: 'Speakers',
      showMenu: true,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Speakers')
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

buildSpeakers(List<QueryDocumentSnapshot> data, BuildContext context) {
  return ListView.builder(
    itemBuilder: (context, index) {
      var doc = data[index].data()! as Map<String, dynamic>;

      return Column(
        children: [
          if (index == 0) SizedBox(height: 20),
          ListTile(
            leading: Hero(
              tag: 'image$index',
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(227, 207, 224, 1)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: CachedNetworkImage(
                    imageUrl: doc['image'] ?? '',
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    errorWidget: (context, _, __) {
                      return Center(
                        child: Icon(
                          Icons.error,
                          size: 38,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            onTap: () {
              if (((doc['about'] ?? '') as String).isNotEmpty)
                Navigator.pushNamed(
                  context,
                  AboutSpeaker.routeName,
                  arguments: {
                    'index': index,
                    'name': doc['name'] ?? '',
                    'about': doc['about'],
                    'image': doc['image'] ?? ''
                  },
                );
              else {
                Fluttertoast.showToast(
                  msg: 'Profile not Available',
                  textColor: Colors.white,
                  backgroundColor: Color.fromRGBO(165, 54, 146, 1),
                );
              }
            },
            title: Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: Text(
                doc['name'] ?? '',
                style: TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            subtitle: Padding(
                padding: const EdgeInsets.only(top: 4, left: 10, bottom: 5),
                child: Text(
                  doc['title'] ?? '',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontFamily: 'Montserrat',
                    color: Color.fromRGBO(144, 144, 144, 1),
                    fontWeight: FontWeight.w400,
                  ),
                )),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Color.fromRGBO(165, 54, 146, 1),
              size: 20,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(93, 0, 10, 0),
            child: Divider(
              color: Color.fromRGBO(165, 54, 146, 1),
              height: 6,
            ),
          ),
        ],
      );
    },
    itemCount: data.length,
  );
}
