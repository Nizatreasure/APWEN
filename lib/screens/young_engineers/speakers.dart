import 'package:apwen/screens/young_engineers/p_and_s_about.dart';
import 'package:apwen/screens/young_engineers/panelists.dart';
import 'package:flutter/material.dart';

class YoungEngineersSpeakers extends StatelessWidget {
  static const String routeName = '/youngengineersspeakers';
  YoungEngineersSpeakers({Key? key}) : super(key: key);

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
                        'subAbout': speakers[index].subAbout,
                        'name': speakers[index].name
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

  final List<YEPanelistsAndSpeakers> speakers = [
    YEPanelistsAndSpeakers(
        name: 'Senami Johnson-Amusu',
        title:
            'Founder, Growwest - An EdTech Financial Literacy and Investment Company.',
        about: [
          'Founder, Growvest - an EdTech financial literacy and investment community',
          'Founder, Growvest - an EdTech financial literacy and investment community',
          'Previously Group Head, Listings & Quotations FMDQ Exchange; & Head, Corporate Finance, Sterling Bank Plc.',
          'Holds certifications in corporate governance, leadership and strategic direction.',
          'Serves as board adviser for 2 startups',
          'Holds MSc in Finance from the Rochester Institute of Technology, New York: and BSc in Economics from the Obafemi Awolowo University.',
          'Recognized in the “Top 100 Career Women in Nigeria 2021”',
          'Passionate about helping women to strategically attain commanding heights in business and leadership',
          'Associate Member and serves under various mentorship capacities in WIMBIZ - Women in Management and Business.',
          'Enjoys watching stage plays at Terra Culture, reading a good novel & running half marathons.'
        ]),
    YEPanelistsAndSpeakers(
        name: 'Roseline Cletus Igah',
        title: 'Head, IT Solutions Delivery, Unified Payment Serivces Ltd.',
        about: [
          'Group Head, IT Solutions Delivery, Unified Payment Services Ltd formerly known as ValuCard',
          'Manages a group of IT professionals who day to day work involve innovation, problem solving, critical & analytical thinking and creativity',
          'Skilled in Project Management, Business Analysis, Solutions implementation and Electronic Payment Systems in MasterCard, Visa, American Express, UnionPay and PayAttitude',
          'Holds a B.Eng in Mechanical Engineering from Federal University of Technology Minna; and MSc in Engineering and Management from Coventry University UK.',
          'APWEN International Representative for Society of Women Engineers (SWE) USA',
          'Obtained a High-Performance Leadership Certificate from Cornel University USA',
          'Holds the Oracle Certified Professional Certification',
          'Member, Oracle Institute USA; Member, Project Management Institute USA',
          'Avid STEM advocate '
        ]),
    YEPanelistsAndSpeakers(
        name: 'Tolu Dima-Okojie',
        title: 'Managing Partner, Kola Akomolede & Company.',
        about: [
          'Managing Partner, Kola Akomolede & Company',
          'Money Behaviour Strategist & Certified Financial Education Instructor',
          'Creator, Money Behaviour Quotient [The MBQ] - a tool for assessing how your lifestyle is hindering you or helping you to build wealth',
          'Founder, Money Map Academy - a finance literacy organization ',
          'Co-founder, Nestegg Financial Planning & Consultant Ltd',
          'Works with organizations to train their teams on how to implement life changing money strategies that will increase productivity',
          'Author of 21 Steps to Move from Broke to More Than Enough',
          'Registered Real Estate Surveyor & Valuer',
          'Member, Personal Finance Society & Member, Chartered Insurance Institute (UK)'
        ])
  ];
}
