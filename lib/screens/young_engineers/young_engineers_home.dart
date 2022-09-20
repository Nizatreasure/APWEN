import 'package:apwen/drawer.dart';
import 'package:apwen/page_decoration.dart';
import 'package:apwen/screens/home_page.dart';
import 'package:apwen/screens/young_engineers/social_events.dart';
import 'package:apwen/screens/young_engineers/questions.dart';
import 'package:apwen/screens/young_engineers/schedule_items/schedule.dart';
import 'package:apwen/screens/young_engineers/speakers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class YoungEngineersHome extends StatelessWidget {
  static const String routeName = '/youngengineershome';
  YoungEngineersHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageDecoration(
      showMenu: true,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('questions')
              .orderBy('id')
              .snapshots(),
          builder: (context, snapshot) {
            return ListView(
              children: [
                SizedBox(height: 20),
                Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.microphone,
                        color: Color.fromRGBO(165, 54, 146, 1),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                            context, YoungEngineersSpeakers.routeName);
                      },
                      title: Text(
                        'Speakers',
                        style: TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            'See the Speakers',
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
                      padding: EdgeInsets.fromLTRB(70, 0, 10, 0),
                      child: Divider(
                        color: Color.fromRGBO(165, 54, 146, 1),
                        height: 6,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.calendarAlt,
                        color: Color.fromRGBO(165, 54, 146, 1),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                            context, YoungEngineersSchedule.routeName);
                      },
                      title: Text(
                        'Schedule',
                        style: TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            'See the programme of event',
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
                      padding: EdgeInsets.fromLTRB(70, 0, 10, 0),
                      child: Divider(
                        color: Color.fromRGBO(165, 54, 146, 1),
                        height: 6,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.deck,
                        color: Color.fromRGBO(165, 54, 146, 1),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, SocialEvents.routeName);
                      },
                      title: Text(
                        'Social Events',
                        style: TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            'See the fun activities available',
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
                      padding: EdgeInsets.fromLTRB(70, 0, 10, 0),
                      child: Divider(
                        color: Color.fromRGBO(165, 54, 146, 1),
                        height: 6,
                      ),
                    ),
                  ],
                ),
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty)
                  Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          FontAwesomeIcons.question,
                          color: Color.fromRGBO(165, 54, 146, 1),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, Questions.routeName,
                              arguments: snapshot.data!.docs);
                        },
                        title: Text(
                          'Q&A Links',
                          style: TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              'Got any Question? Ask!',
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
                        padding: EdgeInsets.fromLTRB(70, 0, 10, 0),
                        child: Divider(
                          color: Color.fromRGBO(165, 54, 146, 1),
                          height: 6,
                        ),
                      ),
                    ],
                  ),
              ],
            );
          }),
      pageHeader: 'Young Engineers',
    );
  }
}
