import 'package:apwen/drawer.dart';
import 'package:apwen/screens/about_apwen.dart';
import 'package:apwen/screens/about_speakers.dart';
import 'package:apwen/screens/programme.dart';
import 'package:apwen/screens/social_events.dart';
import 'package:apwen/screens/sponsors.dart';
import 'package:apwen/screens/stream_live.dart';
import 'package:apwen/screens/topics_speakers.dart';
import 'package:apwen/screens/young_engineers/schedule_items/schedule.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';

  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late TapGestureRecognizer _gestureRecognizer;

  Future<void> openUrl(String url, BuildContext context) async {
    if (await canLaunch(url))
      launch(url);
    else
      showError(context);
  }

  // Map<int, Executives> names = {
  //   1: Executives(name: 'Engr. Funmilola Ojelade, FNSE', position: 'President'),
  //   2: Executives(
  //       name: 'Engr. Dr. Eterigho Elizabeth, FNSE', position: 'Vice President'),
  //   3: Executives(
  //       name: 'Engr. Chinyere Igwegbe, FNSE', position: 'General Secretary'),
  //   4: Executives(
  //       name: 'Engr. Linda Nnodi, MNSE', position: 'Asst. Gen. Secretary'),
  //   5: Executives(
  //       name: 'Engr. Dr. Imhade P. Okokpujie, MNSE',
  //       position: 'Nat. Tech. Secretary'),
  //   6: Executives(
  //       name: 'Engr. Laolu Adedapo-Aisida, FNSE',
  //       position: 'Financial Secretary'),
  //   7: Executives(name: 'Engr. Sylvia Kelechi, MNSE', position: 'Treasurer'),
  //   8: Executives(
  //       name: 'Engr. Bosede Oyekunle, MNSE', position: 'Publicity Secretary'),
  //   9: Executives(name: 'Engr. Evangeline Ekoh, MNSE', position: 'Ex-Officio'),
  //   10: Executives(name: 'Engr. Dr. Zainab Yunusa, MNSE', position: ''),
  //   11: Executives(
  //       name: 'Engr. Anthonia Oyebode, MNSE', position: 'Ex-Officio'),
  //   12: Executives(
  //       name: 'Engr. Maryjane Okoli, MNSE', position: 'Internal Auditor'),
  //   13: Executives(
  //       name: 'Engr. Dr. Felicia Nnenna Agubata, FNSE',
  //       position: 'Imm. Past President'),
  //   14: Executives(
  //       name: 'Engr. Chinelo Ojukwu, MNSE',
  //       position: 'North-Central Zonal Administrator'),
  //   15: Executives(
  //       name: 'Engr. Kori Shettima, MNSE',
  //       position: 'North-East Zonal Administrator'),
  //   16: Executives(
  //       name: 'Engr. Binta Usman, PhD',
  //       position: 'North-West Zonal Adminstrator'),
  //   17: Executives(
  //       name: 'Engr. Josephine O. Ezekwerembah',
  //       position: 'South-east Zonal Administrator'),
  //   18: Executives(
  //       name: 'Engr. Mojirade Oloruntoba, FNSE',
  //       position: 'South-West Zonal Administrator'),
  //   19: Executives(
  //       name: 'Engr. Dr. Adebisi Osim, MNSE',
  //       position: 'South-South Zonal Administrator'),
  //   20: Executives(
  //       name: 'Engr. Ummulkhair Mukhtar Tajo',
  //       position: 'Young Engineers Coordinator'),
  //   21: Executives(
  //       name: 'Engr. Oduwa Agboneni, MNSE', position: 'Brand Ambassador'),
  //   22: Executives(
  //       name: 'Engr. Zansi Adebowale, MNSE',
  //       position: 'Strategic Brand Director')
  // };
  List<NavButton> nav = [
    NavButton(
        title: 'Speakers',
        icon: FontAwesomeIcons.microphone,
        route: TopicsSpeakers.routeName),
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
        route: Sponsors.routeName),
    NavButton(
        title: 'Events', icon: Icons.event, route: SocialEvents.routeName),
    NavButton(
        title: 'About',
        icon: FontAwesomeIcons.infoCircle,
        route: AboutAPWEN.routeName),
  ];

  @override
  void initState() {
    _gestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        openUrl('https://www.apwen.org', context);
      };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 5, top: 5),
          child: Row(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: Image.asset('assets/logo.png'),
              ),
              SizedBox(width: 20),
              RichText(
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(fontSize: 22),
                  children: [
                    TextSpan(text: 'A'),
                    TextSpan(text: 'P'),
                    TextSpan(
                      text: 'W',
                      style: TextStyle(color: Theme.of(context).hintColor),
                    ),
                    TextSpan(text: 'E'),
                    TextSpan(text: 'N'),
                  ],
                ),
              ),
            ],
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
      body: ListView(
        children: [
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyText1?.color),
                    children: [
                      TextSpan(
                        text: '2021',
                        style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontSize: 32,
                            fontWeight: FontWeight.normal),
                      ),
                      TextSpan(text: ' International')
                    ],
                  ),
                ),
                // Text(
                //   '2021 International',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(fontSize: 30, fontFamily: 'Montserrat'),
                // ),
                Text(
                  ' Conference &',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Montserrat',
                      fontStyle: FontStyle.italic),
                ),
                Text(
                  'Annual General Meeting',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, StreamLive.routeName);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue[700]),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(double.infinity, 45),
                ),
              ),
              child: Text(
                ' Stream live event',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GridView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  mainAxisExtent: 120),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (nav[index].title == 'Schedule') {
                      Navigator.pushNamed(context, nav[index].route);
                    } else {
                      selected = nav[index].route;
                      Navigator.pushReplacementNamed(context, nav[index].route);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                    decoration: BoxDecoration(
                      // color: Theme.of(context).textTheme.bodyText1?.color,
                      color: Color(0xff183750),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          nav[index].icon,
                          color: Color(0xffddd0df),
                        ),
                        SizedBox(height: 10),
                        Text(
                          nav[index].title,
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              nav[index].title == 'Schedule'
                                  ? 'Young Engineers'
                                  : 'APWEN 2021',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_right_alt,
                              color: Color(0xffddd0df),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: 6,
            ),
          ),
          // SizedBox(height: 30),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 25),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text('National',
          //           style: Theme.of(context)
          //               .textTheme
          //               .bodyText1
          //               ?.copyWith(color: Theme.of(context).hintColor)),
          //       Text('Executives',
          //           style: Theme.of(context).textTheme.bodyText1),
          //     ],
          //   ),
          // ),
          // CarouselSlider(
          //   items: List.generate(22, (index) => index + 1)
          //       .map((e) => Column(
          //             children: [
          //               Expanded(
          //                 child: Container(
          //                   margin: EdgeInsets.fromLTRB(0, 20, 10, 20),
          //                   width: width,
          //                   height: 250,
          //                   child: ClipRRect(
          //                     borderRadius: BorderRadius.circular(8),
          //                     child: Image.asset(
          //                       'assets/executives/$e.jpeg',
          //                       fit: BoxFit.cover,
          //                       alignment: Alignment.topCenter,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.symmetric(horizontal: 10),
          //                 child: Column(
          //                   children: [
          //                     Text(
          //                         names.entries
          //                             .firstWhere((element) => element.key == e)
          //                             .value
          //                             .name,
          //                         textAlign: TextAlign.center,
          //                         style: Theme.of(context)
          //                             .textTheme
          //                             .bodyText2
          //                             ?.copyWith(fontSize: 20)),
          //                     SizedBox(height: 3),
          //                     Text(
          //                       names.entries
          //                           .firstWhere((element) => element.key == e)
          //                           .value
          //                           .position,
          //                       textAlign: TextAlign.center,
          //                       style: Theme.of(context)
          //                           .textTheme
          //                           .bodyText2
          //                           ?.copyWith(
          //                               fontSize: 17, color: Colors.black54),
          //                     ),
          //                   ],
          //                 ),
          //               )
          //             ],
          //           ))
          //       .toList(),
          //   options: CarouselOptions(
          //     autoPlay: true,
          //     height: 350,
          //     enableInfiniteScroll: true,
          //     viewportFraction: 0.8,
          //     enlargeCenterPage: true,
          //     autoPlayAnimationDuration: Duration(seconds: 1),
          //   ),
          // ),
          SizedBox(height: 30),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.normal,
                            height: 1.5,
                          ),
                      children: [
                        TextSpan(
                          text: 'The APWEN Conference ',
                          style: TextStyle(
                              color: Theme.of(context).hintColor,
                              fontSize: 18,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                            text:
                                'is an annual event organised by the Association of Professional Women Engineers (APWEN) . APWEN conferences focus on collecting and encouraging the dissemination of technical knowledge and technologies related to Engineering and Technology with special emphasis on female Engineers. Over the years APWEN conference has grown to become the largest  gathering of Female Engineers  in Africa, attracting captains of industry, the academia, regulators, high level government officials and other key industry stakeholders.\n'),
                        TextSpan(
                            text:
                                'APWEN is hosting her 2021 edition of the annual Conference from September 20th to 23rd, 2021, at the Nile University Abuja, FCT.  The theme of the 2021 conference is " *Women Engineers Driving Digital Transformation in Nigeria* ”.\n\n'),
                        TextSpan(text: 'Register at'),
                        TextSpan(
                            text: '  www.apwen.org',
                            style: TextStyle(color: Colors.blue),
                            recognizer: _gestureRecognizer),
                      ],
                    ),
                  ),
                  SizedBox(height: 30)
                ],
              ),
            ),
          )
        ],
      ),
      endDrawer: AppDrawer(),
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
