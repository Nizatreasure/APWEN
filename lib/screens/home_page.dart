import 'package:apwen/drawer.dart';
import 'package:apwen/screens/about_apwen.dart';
import 'package:apwen/screens/about_speakers.dart';
import 'package:apwen/screens/programme.dart';
import 'package:apwen/screens/social_events.dart';
import 'package:apwen/screens/sponsors.dart';
import 'package:apwen/screens/topics_speakers.dart';
import 'package:apwen/screens/young_engineers/schedule_items/schedule.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';

  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Map<int, Executives> names = {
    1: Executives(name: 'Engr. Funmilola Ojelade, FNSE', position: 'President'),
    2: Executives(
        name: 'Engr. Dr. Eterigho Elizabeth, FNSE', position: 'Vice President'),
    3: Executives(
        name: 'Engr. Chinyere Igwegbe, FNSE', position: 'General Secretary'),
    4: Executives(
        name: 'Engr. Linda Nnodi, MNSE', position: 'Asst. Gen. Secretary'),
    5: Executives(
        name: 'Engr. Dr. Imhade P. Okokpujie, MNSE',
        position: 'Nat. Tech. Secretary'),
    6: Executives(
        name: 'Engr. Laolu Adedapo-Aisida, FNSE',
        position: 'Financial Secretary'),
    7: Executives(name: 'Engr. Sylvia Kelechi, MNSE', position: 'Treasurer'),
    8: Executives(
        name: 'Engr. Bosede Oyekunle, MNSE', position: 'Publicity Secretary'),
    9: Executives(name: 'Engr. Evangeline Ekoh, MNSE', position: 'Ex-Officio'),
    10: Executives(name: 'Engr. Dr. Zainab Yunusa, MNSE', position: ''),
    11: Executives(
        name: 'Engr. Anthonia Oyebode, MNSE', position: 'Ex-Officio'),
    12: Executives(
        name: 'Engr. Maryjane Okoli, MNSE', position: 'Internal Auditor'),
    13: Executives(
        name: 'Engr. Dr. Felicia Nnenna Agubata, FNSE',
        position: 'Imm. Past President'),
    14: Executives(
        name: 'Engr. Chinelo Ojukwu, MNSE',
        position: 'North-Central Zonal Administrator'),
    15: Executives(
        name: 'Engr. Kori Shettima, MNSE',
        position: 'North-East Zonal Administrator'),
    16: Executives(
        name: 'Engr. Binta Usman, PhD',
        position: 'North-West Zonal Adminstrator'),
    17: Executives(
        name: 'Engr. Josephine O. Ezekwerembah',
        position: 'South-east Zonal Administrator'),
    18: Executives(
        name: 'Engr. Mojirade Oloruntoba, FNSE',
        position: 'South-West Zonal Administrator'),
    19: Executives(
        name: 'Engr. Dr. Adebisi Osim, MNSE',
        position: 'South-South Zonal Administrator'),
    20: Executives(
        name: 'Engr. Ummulkhair Mukhtar Tajo',
        position: 'Young Engineers Coordinator'),
    21: Executives(
        name: 'Engr. Oduwa Agboneni, MNSE', position: 'Brand Ambassador'),
    22: Executives(
        name: 'Engr. Zansi Adebowale, MNSE',
        position: 'Strategic Brand Director')
  };
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
        title: 'Resources',
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
                  Text(
                    'Vision',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 25, color: Theme.of(context).hintColor),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'To be the catalyst for advancement of women in the engineering profession towards national and global technological development.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontWeight: FontWeight.normal, height: 1.4),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Mission',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 25, color: Theme.of(context).hintColor),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'To continuously increase awareness that engineering is a career for girls also, thereby improving the numerical strength of female engineers.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontWeight: FontWeight.normal, height: 1.4),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'To encourage women to achieve professional excellence as engineers and leaders.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontWeight: FontWeight.normal, height: 1.4),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'To promote the engineering profession as a positive force in enhancing the quality of life.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontWeight: FontWeight.normal, height: 1.4),
                  ),
                  SizedBox(height: 20)
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
