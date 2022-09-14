import 'package:apwen/screens/about_apwen.dart';
import 'package:apwen/screens/home_page.dart';
import 'package:apwen/screens/programme.dart';
import 'package:apwen/screens/social_events.dart';
import 'package:apwen/screens/sponsors.dart';
import 'package:apwen/screens/topics_speakers.dart';
import 'package:apwen/screens/young_engineers/young_engineers_home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

String selected = '/';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black26,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: RawScrollbar(
                  thumbColor: Color(0xFF1C293D),
                  thickness: 3,
                  child: ListView(
                    children: [
                      GestureDetector(
                        onTap: () {
                          openUrl('https://www.apwen.org', context);
                        },
                        child: Container(
                          height: 140,
                          width: double.infinity,
                          color: Colors.black12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: Image.asset('assets/logo.png'),
                              ),
                              SizedBox(width: 15),
                              RichText(
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
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).hintColor)),
                                    TextSpan(
                                      text: 'E',
                                    ),
                                    TextSpan(text: 'N\n'),
                                    TextSpan(text: 'Conference')
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            appDrawerButton(
                                name: 'Home', path: HomePage.routeName),
                            SizedBox(height: 10),
                            appDrawerButton(
                                name: 'Speakers',
                                path: TopicsSpeakers.routeName),
                            SizedBox(height: 10),
                            appDrawerButton(
                                name: 'Social Events',
                                path: SocialEvents.routeName),
                            SizedBox(height: 10),
                            appDrawerButton(
                                name: 'Programme', path: Programme.routeName),
                            SizedBox(height: 10),
                            appDrawerButton(
                                name: 'Young Engineers',
                                path: YoungEngineersHome.routeName),
                            SizedBox(height: 10),
                            appDrawerButton(
                                name: 'Sponsors', path: Sponsors.routeName),
                            SizedBox(height: 10),
                            appDrawerButton(
                                name: 'About APWEN',
                                path: AboutAPWEN.routeName),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.black12,
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
    );
  }

  appDrawerButton({required String name, required String path}) {
    return TextButton(
      onPressed: () {
        if (selected == path) {
          Navigator.pop(context);
        } else {
          setState(() {
            selected = path;
          });
          Navigator.of(context).pushReplacementNamed(
            path,
          );
        }
      },
      style: Theme.of(context).textButtonTheme.style,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            border: selected == path
                ? Border.all(
                    color: Color(0xFF1C293D),
                  )
                : null,
            borderRadius: BorderRadius.circular(8)),
        child: Text(
          name,
          style: Theme.of(context).textTheme.button?.copyWith(fontSize: 22),
        ),
      ),
    );
  }
}

Future<void> openUrl(String url, BuildContext context) async {
  if (await canLaunchUrl(Uri.parse(url)))
    launchUrl(Uri.parse(url));
  else
    showError(context);
}

Future<void> showError(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.brown[300],
          content: Text(
            'Could not launch application',
            style: TextStyle(color: Colors.brown[800]),
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.brown[900], fontSize: 16),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}
