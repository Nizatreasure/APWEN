import 'package:apwen/drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
        name: 'Engr. CHinyere Igwegbe, FNSE', position: 'General Secretary'),
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 5, top: 5),
          child: RichText(
            text: TextSpan(
              style:
                  Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 25),
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
          // Text('APWEN',
          //     style: TextStyle(fontSize: 25, fontFamily: 'Montserrat')),
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
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('National',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Theme.of(context).hintColor)),
                Text('Executives',
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ),
          CarouselSlider(
            items: List.generate(22, (index) => index + 1)
                .map((e) => Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 10, 20),
                            width: width,
                            height: 250,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/executives/$e.jpeg',
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Text(
                                  names.entries
                                      .firstWhere((element) => element.key == e)
                                      .value
                                      .name,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(fontSize: 20)),
                              SizedBox(height: 3),
                              Text(
                                names.entries
                                    .firstWhere((element) => element.key == e)
                                    .value
                                    .position,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                        fontSize: 17, color: Colors.black54),
                              ),
                            ],
                          ),
                        )
                      ],
                    ))
                .toList(),
            options: CarouselOptions(
              autoPlay: true,
              height: 350,
              enableInfiniteScroll: true,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
              autoPlayAnimationDuration: Duration(seconds: 1),
            ),
          ),
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontSize: 25),
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
                  Text('Mission',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(fontSize: 25)),
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
