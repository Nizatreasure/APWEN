import 'package:apwen/screens/young_engineers/p_and_s_about.dart';
import 'package:apwen/screens/young_engineers/panelists.dart';
import 'package:flutter/material.dart';

class YoungEngineersSpeakers extends StatelessWidget {
  static const String routeName = '/youngengineersspeakers';
  YoungEngineersSpeakers({Key? key}) : super(key: key);

  final List<YEPanelistsAndSpeakers> speakers = [
    YEPanelistsAndSpeakers(
        name: 'Senami Johnson-Amusu',
        title:
            'Founder, Growwest - An EdTech Financial Literacy and Investment Company.',
        about: []),
    YEPanelistsAndSpeakers(
        name: 'Roseline Cletus Igah',
        title: 'Head, IT Solutions Delivery, Unified Payment Serivces Ltd.',
        about: []),
    YEPanelistsAndSpeakers(
        name: 'Tolu Dima-Okojie',
        title: 'Managing Partner, Kola Akomolede & Company.',
        about: [])
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 5, top: 5),
          child: RichText(
            text: TextSpan(
              style:
                  Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 21),
              children: [
                TextSpan(text: 'S'),
                TextSpan(text: 'P'),
                TextSpan(text: 'E'),
                TextSpan(
                  text: 'A',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                TextSpan(text: 'K'),
                TextSpan(text: 'E'),
                TextSpan(text: 'R'),
                TextSpan(text: 'S'),
              ],
            ),
          ),
        ),
        toolbarHeight: 65,
        elevation: 1,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(height: 20),
              ListTile(
                leading: Hero(
                  tag: 'image$index',
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red[200]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        'assets/y_speakers/${index + 1}.jpg',
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                      context, YoungEngineersPAndSAbout.routeName,
                      arguments: {
                        'index': index,
                        'path': 'y_speakers/${index + 1}.jpg',
                        'about': speakers[index].about,
                        'subAbout': speakers[index].subAbout
                      });
                },
                title: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    speakers[index].name,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat'),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4, left: 10),
                  child: Text(
                    speakers[index].title,
                    style: TextStyle(
                        fontSize: 15, fontFamily: 'Lato', height: 1.3),
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 70, right: 10),
                  child: Divider(
                    color: Colors.black,
                  ))
            ],
          );
        },
        itemCount: speakers.length,
      ),
    );
  }
}
