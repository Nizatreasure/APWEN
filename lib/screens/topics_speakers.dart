import 'package:apwen/drawer.dart';
import 'package:apwen/screens/about_speakers.dart';
import 'package:apwen/screens/topic_brief.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TopicsSpeakers extends StatefulWidget {
  static const routeName = '/topicsandspeakers';
  TopicsSpeakers({Key? key}) : super(key: key);

  @override
  _TopicsSpeakersState createState() => _TopicsSpeakersState();
}

class _TopicsSpeakersState extends State<TopicsSpeakers> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 5, top: 5),
          child: RichText(
            text: TextSpan(
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontSize: 25),
                children: [
                  TextSpan(text: 'A'),
                  TextSpan(
                    text: 'P',
                  ),
                  TextSpan(
                      text: 'W',
                      style: TextStyle(color: Theme.of(context).hintColor)),
                  TextSpan(
                    text: 'E',
                  ),
                  TextSpan(text: 'N'),
                ]),
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: Icon(Icons.notes_rounded),
            splashColor: Colors.transparent,
          )
        ],
      ),
      endDrawer: AppDrawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Speakers')
            .orderBy('name')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (!(snapshot.hasData) || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No data'),
            );
          }

          return _buildSpeakers(snapshot.requireData.docs);
        },
      ),
    );
  }

  _buildSpeakers(List<QueryDocumentSnapshot> data) {
    return ListView.builder(
      itemBuilder: (context, index) {
        var doc = data[index].data()! as Map<String, dynamic>;
        print(doc);
        return Column(
          children: [
            if (index == 0) SizedBox(height: 30),
            ListTile(
              leading: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AboutSpeaker.routeName,
                    arguments: {
                      'index': index,
                      'name': doc['name'] ?? '',
                      'aboutSpeakers': doc['about_speaker'] ?? '',
                      'image': doc['image'] ?? ''
                    },
                  );
                },
                child: Hero(
                  tag: 'image$index',
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red[200]),
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
              ),
              onTap: () {
                Navigator.pushNamed(context, TopicBrief.routeName, arguments: {
                  'index': index,
                  'aboutSpeaker': doc['about_speaker'] ?? '',
                  'aboutTopic': doc['about_topic'] ?? '',
                  'name': doc['name'] ?? '',
                  'id': doc['id'] ?? index,
                  'topic': doc['topic'] ?? '',
                  'image': doc['image'] ?? ''
                });
              },
              title: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  doc['name'] ?? '',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4, left: 10),
                  child: Text(
                    doc['title'] ?? '',
                    style: TextStyle(fontSize: 15),
                  )),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            if (index != 21)
              Padding(
                padding: EdgeInsets.fromLTRB(70, 0, 10, 0),
                child: Divider(
                  color: Color(0xFF1C293D),
                ),
              ),
          ],
        );
      },
      itemCount: data.length,
    );
  }
}
