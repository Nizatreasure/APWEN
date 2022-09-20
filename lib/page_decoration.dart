import 'package:apwen/drawer.dart';
import 'package:apwen/provider.dart';
import 'package:apwen/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PageDecoration extends StatelessWidget {
  final Widget child;
  final bool showMenu;
  final String pageHeader;
  PageDecoration(
      {required this.child,
      this.showMenu = false,
      required this.pageHeader,
      Key? key})
      : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ConnectivityProvider provider = Provider.of<ConnectivityProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      backgroundColor:
          provider.connected ? Colors.white : Color.fromRGBO(165, 54, 146, 1),
      body: WillPopScope(
        onWillPop: () async {
          if (showMenu) {
            selected = HomePage.routeName;
            Navigator.pushReplacementNamed(context, HomePage.routeName);
            return false;
          } else {
            return true;
          }
        },
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 0, 7, 0),
                          child: GestureDetector(
                            onTap: () {
                              if (showMenu) {
                                _scaffoldKey.currentState?.openDrawer();
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            child: Container(
                              alignment: Alignment.topCenter,
                              child: Icon(
                                showMenu ? Icons.menu : Icons.west,
                                size: 28,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              alignment: Alignment.center,
                              child: Text(
                                pageHeader,
                                style: TextStyle(
                                  color: Color.fromRGBO(165, 54, 146, 1),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            openUrl('https://www.apwen.org', context);
                          },
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 8, right: 12, top: 5),
                            child: Container(
                              height: 30,
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
                Expanded(child: child),
                if (showMenu)
                  Container(
                    color: Color.fromRGBO(217, 217, 217, 1),
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            openUrl('https://web.facebook.com/apwen.apwen.3',
                                context);
                          },
                          icon: Icon(
                            FontAwesomeIcons.facebookF,
                            size: 30,
                            color: Color(0xff4267b2),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            openUrl(
                                'https://www.twitter.com/apwen_ng', context);
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
                            openUrl('https://www.instagram.com/apwennational',
                                context);
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
      ),
    );
  }
}
