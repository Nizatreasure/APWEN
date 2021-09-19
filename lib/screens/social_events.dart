import 'package:apwen/drawer.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class SocialEvents extends StatefulWidget {
  static const String routeName = '/socialevents';
  SocialEvents({Key? key}) : super(key: key);

  @override
  _SocialEventsState createState() => _SocialEventsState();
}

class _SocialEventsState extends State<SocialEvents> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 60,
        title: Padding(
          padding: const EdgeInsets.only(left: 5, top: 5),
          child: RichText(
            text: TextSpan(
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontSize: 26),
                children: [
                  TextSpan(text: 'S'),
                  TextSpan(
                    text: 'o',
                  ),
                  TextSpan(
                      text: 'c',
                      style: TextStyle(color: Theme.of(context).hintColor)),
                  TextSpan(
                    text: 'i',
                  ),
                  TextSpan(text: 'a'),
                  TextSpan(text: 'l'),
                  TextSpan(text: '   '),
                  TextSpan(text: 'E'),
                  TextSpan(
                    text: 'v',
                  ),
                  TextSpan(
                      text: 'e',
                      style: TextStyle(color: Theme.of(context).hintColor)),
                  TextSpan(text: 'n'),
                  TextSpan(text: 't'),
                  TextSpan(text: 's'),
                ]),
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 1,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            SizedBox(height: 30),
            TimelineTile(
              node: TimelineNode.simple(
                indicatorPosition: 0,
                color: Theme.of(context).hintColor.withOpacity(0.5),
                indicatorSize: 17,
              ),
              contents: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        '20/09',
                        style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      color: Color(0xfffffaf8),
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Monday, 20th September 2021',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Kayaking',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '@Amazon Kayak, Jabi',
                                    style: TextStyle(
                                        fontSize: 22, fontFamily: 'Montserrat'),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: 80,
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28,
                                          color: Theme.of(context).hintColor,
                                          fontFamily: 'Montserrat'),
                                      children: [
                                        TextSpan(text: '3'),
                                        TextSpan(
                                          text: 'pm',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      shadowColor: Theme.of(context).textTheme.bodyText1?.color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
              nodeAlign: TimelineNodeAlign.start,
            ),
            TimelineTile(
              node: TimelineNode.simple(
                indicatorPosition: 0,
                color: Theme.of(context).hintColor.withOpacity(0.5),
                indicatorSize: 17,
              ),
              contents: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        '22/09',
                        style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      color: Color(0xfffffaf8),
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Wednesday, 22nd September 2021',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Groovy 70s and Psychedelic 80s Disco Party',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '@AES Luxury Apartment Hotel, Jabi',
                                    style: TextStyle(
                                        fontSize: 22, fontFamily: 'Montserrat'),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: 80,
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28,
                                          color: Theme.of(context).hintColor,
                                          fontFamily: 'Montserrat'),
                                      children: [
                                        TextSpan(text: '7'),
                                        TextSpan(
                                          text: 'pm',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      shadowColor: Theme.of(context).textTheme.bodyText1?.color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 15)
                  ],
                ),
              ),
              nodeAlign: TimelineNodeAlign.start,
            ),
            TimelineTile(
              node: TimelineNode.simple(
                indicatorPosition: 0,
                color: Theme.of(context).hintColor.withOpacity(0.5),
                indicatorSize: 17,
              ),
              contents: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        '23/09',
                        style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      color: Color(0xfffffaf8),
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Thursday, 23rd September 2021',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Dinner & Awards Night',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '@AES Luxury Apartment Hotel, Jabi',
                                    style: TextStyle(
                                        fontSize: 22, fontFamily: 'Montserrat'),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: 80,
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28,
                                          color: Theme.of(context).hintColor,
                                          fontFamily: 'Montserrat'),
                                      children: [
                                        TextSpan(text: '7'),
                                        TextSpan(
                                          text: 'pm',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      shadowColor: Theme.of(context).textTheme.bodyText1?.color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              nodeAlign: TimelineNodeAlign.start,
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
