import 'package:apwen/screens/about_apwen.dart';
import 'package:apwen/screens/home_page.dart';
import 'package:apwen/screens/panelists.dart';
import 'package:apwen/screens/programme.dart';
import 'package:apwen/screens/sponsors.dart';
import 'package:apwen/screens/topics_speakers.dart';
import 'package:apwen/screens/young_engineers/young_engineers_home.dart';
import 'package:flutter/material.dart';
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
    return Container(
      color: Color.fromRGBO(234, 225, 232, 1),
      width: 0.7 * MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RawScrollbar(
                thumbColor: Color.fromRGBO(165, 54, 146, 0.43),
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
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromRGBO(165, 54, 146, 1),
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Column(
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
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Lobster',
                                  fontSize: 16.5,
                                ),
                                children: [
                                  TextSpan(text: 'A'),
                                  TextSpan(
                                    text: 'P',
                                  ),
                                  TextSpan(
                                    text: 'W',
                                    style: TextStyle(
                                      color: Color.fromRGBO(165, 54, 146, 1),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'E',
                                  ),
                                  TextSpan(text: 'N '),
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
                              name: 'Speakers', path: TopicsSpeakers.routeName),
                          SizedBox(height: 10),
                          appDrawerButton(
                              name: 'Panelists', path: Panelists.routeName),
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
                              name: 'About APWEN', path: AboutAPWEN.routeName),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  appDrawerButton({required String name, required String path}) {
    return GestureDetector(
      onTap: () {
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
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: selected == path ? Color.fromRGBO(165, 54, 146, 0.43) : null,
          borderRadius: BorderRadius.circular(15),
          boxShadow: selected == path
              ? [
                  BoxShadow(
                    offset: Offset(0, 4),
                    color: Color.fromRGBO(62, 6, 52, 0.5),
                    blurRadius: 4,
                    spreadRadius: 0,
                  )
                ]
              : null,
        ),
        child: Text(
          name,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
            fontWeight: selected == path ? FontWeight.w600 : FontWeight.w500,
            color: selected == path ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

Future<void> openUrl(String url, BuildContext context,
    {LaunchMode launchMode = LaunchMode.externalApplication}) async {
  if (await canLaunchUrl(Uri.parse(url)))
    launchUrl(
      Uri.parse(url),
      mode: launchMode,
    );
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
