import 'dart:convert';

import 'package:apwen/drawer.dart';
import 'package:apwen/provider.dart';
import 'package:apwen/screens/about_apwen.dart';
import 'package:apwen/screens/panelists.dart';
import 'package:apwen/screens/programme.dart';
import 'package:apwen/screens/young_engineers/social_events.dart';
import 'package:apwen/screens/sponsors.dart';
import 'package:apwen/screens/stream_live.dart';
import 'package:apwen/screens/topics_speakers.dart';
import 'package:apwen/screens/young_engineers/schedule_items/schedule.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  static const routeName = '/';

  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<NavButton> nav = [
    NavButton(
        title: 'Speakers',
        icon: FontAwesomeIcons.microphone,
        route: TopicsSpeakers.routeName),
    NavButton(
        title: 'Panelists', icon: Icons.group, route: Panelists.routeName),
    NavButton(
        title: 'Schedule',
        icon: FontAwesomeIcons.calendarAlt,
        route: YoungEngineersSchedule.routeName),
    NavButton(
        title: 'Programme',
        icon: FontAwesomeIcons.filePdf,
        route: Programme.routeName),
    NavButton(
      title: 'Sponsors',
      icon: FontAwesomeIcons.peopleCarry,
      route: Sponsors.routeName,
    ),
    NavButton(
      title: 'About',
      icon: FontAwesomeIcons.infoCircle,
      route: AboutAPWEN.routeName,
    ),
  ];
  @override
  void initState() {
    FlutterNativeSplash.remove();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConnectivityProvider provider = Provider.of<ConnectivityProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor:
          provider.connected ? Colors.white : Color.fromRGBO(165, 54, 146, 1),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                color: Color.fromRGBO(165, 54, 146, 1),
                height: provider.connected ? 0 : 50,
                child: Text(
                  'You are not connected to the Internet. Please connect to see new updates.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(12, 3, 7, 0),
                        child: GestureDetector(
                          onTap: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: Icon(
                              Icons.menu,
                              size: 33,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Color.fromRGBO(165, 54, 146, 1),
                                fontFamily: "Lobster",
                              ),
                              children: [
                                TextSpan(text: '2022'),
                                TextSpan(
                                  text: ' I',
                                  style: TextStyle(
                                    color: Color.fromRGBO(202, 145, 0, 1),
                                  ),
                                ),
                                TextSpan(
                                  text: 'nternational',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                    text: ' C',
                                    style: TextStyle(
                                        color: Color.fromRGBO(202, 145, 0, 1))),
                                TextSpan(
                                    text: 'onference',
                                    style: TextStyle(
                                      color: Colors.black,
                                    )),
                                TextSpan(
                                  text: ' &',
                                  style: TextStyle(
                                    color: Color.fromRGBO(69, 69, 69, 1),
                                  ),
                                ),
                                TextSpan(text: ' General Meeting'),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          openUrl('https://www.apwen.org', context);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 8, right: 12, top: 8),
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.asset(
                              'assets/logo.png',
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 10),
              Divider(
                color: Color.fromRGBO(165, 54, 146, 1),
                thickness: 1,
                indent: 0,
                endIndent: 0,
                height: 0,
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    SizedBox(height: 15),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Theme: ',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(165, 54, 146, 1),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Just Energy Transition: An Enabler for Sustainable Development in Nigeria.',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Align(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, StreamLive.routeName);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 48,
                          width: 240,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Color.fromRGBO(165, 54, 146, 1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.videocam_outlined,
                                color: Colors.black,
                              ),
                              SizedBox(width: 20),
                              Text(
                                'Stream Live Event',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            nav[index].title,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                              fontSize: 16.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Icon(
                              nav[index].icon,
                              color: Color.fromRGBO(165, 54, 146, 1),
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Color.fromRGBO(165, 54, 146, 1),
                          ),
                          subtitle: Text(
                            nav[index].title != 'Schedule'
                                ? 'APWEN 2022'
                                : 'Young Engineers',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color.fromRGBO(165, 54, 146, 1),
                              fontSize: 12.5,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onTap: () {
                            if (nav[index].title == 'Schedule') {
                              Navigator.pushNamed(context, nav[index].route);
                            } else {
                              selected = nav[index].route;
                              Navigator.pushReplacementNamed(
                                  context, nav[index].route);
                            }
                          },
                        );
                      },
                      itemCount: nav.length,
                    ),
                  ],
                ),
              ),
              Container(
                color: Color.fromRGBO(217, 217, 217, 1),
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        openUrl(
                            'https://web.facebook.com/apwen.apwen.3', context);
                      },
                      icon: Icon(
                        FontAwesomeIcons.facebookF,
                        size: 30,
                        color: Color(0xff4267b2),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        openUrl('https://www.twitter.com/apwen_ng', context);
                      },
                      icon: Icon(
                        FontAwesomeIcons.twitter,
                        size: 30,
                        color: Color(0xff1da1f2),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        openUrl(
                            'https://www.linkedin.com/in/apwen-national-hq-8440b369',
                            context);
                      },
                      icon: Icon(
                        FontAwesomeIcons.linkedinIn,
                        size: 30,
                        color: Color(0xff0077b5),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        openUrl(
                            'https://www.instagram.com/apwennational', context);
                      },
                      icon: Icon(
                        FontAwesomeIcons.instagram,
                        size: 30,
                        color: Color(0xffcd486b),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        openUrl(
                            'https://youtube.com/channel/UC6tgFLmOTb1IGzYiFDgB9MQ',
                            context);
                      },
                      icon: Icon(
                        FontAwesomeIcons.youtube,
                        size: 30,
                        color: Color(0xffff0000),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}

class Executives {
  String name;
  String position;

  Executives({required this.name, required this.position});
}

class NavButton {
  String title;
  IconData icon;
  String route;
  NavButton({required this.title, required this.icon, required this.route});
}
