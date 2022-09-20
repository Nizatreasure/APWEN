import 'package:apwen/drawer.dart';
import 'package:apwen/page_decoration.dart';
import 'package:apwen/screens/home_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAPWEN extends StatefulWidget {
  static const String routeName = '/aboutapwen';
  AboutAPWEN({Key? key}) : super(key: key);

  @override
  _AboutAPWENState createState() => _AboutAPWENState();
}

class _AboutAPWENState extends State<AboutAPWEN> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late TapGestureRecognizer _gestureRecognizer;

  @override
  void initState() {
    _gestureRecognizer = TapGestureRecognizer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageDecoration(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.5,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(text: 'For more information, visit'),
                      TextSpan(
                        text: ' www.apwen.org',
                        style:
                            TextStyle(color: Color.fromRGBO(165, 54, 146, 1)),
                        recognizer: _gestureRecognizer
                          ..onTap = () {
                            openUrl('https://www.apwen.org', context);
                          },
                      ),
                    ]),
              ),
            ),
            SizedBox(height: 10),
            Card(
              color: Color.fromRGBO(254, 233, 250, 1),
              elevation: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Text(
                      'APWEN Conference',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                          color: Color.fromRGBO(165, 54, 146, 1)),
                    ),
                  ),
                  Divider(
                    color: Color.fromRGBO(165, 54, 146, 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: Column(children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  'The APWEN Conference is an annual event organised by the Association of Professional Women Engineers (APWEN) . APWEN conferences focus on collecting and encouraging the dissemination of technical knowledge and technologies related to Engineering and Technology with special emphasis on female Engineers. Over the years APWEN conference has grown to become the largest  gathering of Female Engineers  in Africa, attracting captains of industry, the academia, regulators, high level government officials and other key industry stakeholders.\n',
                            ),
                            TextSpan(
                                text:
                                    '\nAPWEN is hosting her 2022 edition of the annual Conference from September 19th to 22nd, at Sandralia Hotel, Jabi Abuja, Nigeria.  The theme of the 2022 conference is '),
                            TextSpan(
                                text:
                                    '"Just Energy Transition: An Enabler for Sustainable Development in Nigeria”.\n\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                )),
                            TextSpan(text: 'Register at'),
                            TextSpan(
                              text: '  www.conference.apwen.org.ng',
                              style: TextStyle(
                                color: Color.fromRGBO(165, 54, 146, 1),
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: _gestureRecognizer
                                ..onTap = () {
                                  openUrl('https://conference.apwen.org.ng',
                                      context);
                                },
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                ],
              ),
              shadowColor: Color.fromRGBO(231, 190, 224, 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(height: 15),
            _buildAbout(context, 'Our History',
                'The Association of Professional Women Engineers of Nigeria APWEN was formed by a handful of women engineers led by Engr. (Mrs.) J. O. Maduka in 1982 and was formally inaugurated in 1983. It was originally meant to be a pressure group since most men hiring engineers then would rather have women in the kitchen and not on construction sites or behind the desk carrying out engineering designs.'),
            SizedBox(height: 15),
            Card(
              color: Color.fromRGBO(254, 233, 250, 1),
              elevation: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Text(
                      'What We Do',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                          color: Color.fromRGBO(165, 54, 146, 1)),
                    ),
                  ),
                  Divider(
                    color: Color.fromRGBO(165, 54, 146, 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: Column(children: [
                      Text(
                        'Since 1982, APWEN has recorded a level of achievement of her objectives by advancing professional knowledge of members through:',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 5),
                      _buildBulletList(
                          'Facilitation of continuing professional development workshops.'),
                      _buildBulletList(
                          'Organizing industrial visits to engineering facilities.'),
                      _buildBulletList(
                          'Career counselling sessions for female students in Primary, Secondary and Tertiary institutions to increase awareness and encourage them to study science and engineering.'),
                      _buildBulletList(
                          'Participating as role models and mentors at programmes organized by engineering students of tertiary institutions.'),
                      _buildBulletList(
                          'Giving scholarships and awards to outstanding female engineering students.'),
                      _buildBulletList(
                          'Recognizing and honouring excellence in engineering practice by female engineers.'),
                      _buildBulletList(
                          'Acknowledging employers of female engineers.'),
                      _buildBulletList(
                          'Organizing conferences, seminars, workshops and public lectures.'),
                      _buildBulletList(
                          'Ensuring adequate visibility through publicity coverage of APWEN activities and publishing of newsletters.'),
                      _buildBulletList(
                          'Participating in international conference of Women Engineers and Scientists (ICWES) and World Engineers Conventions.'),
                      SizedBox(height: 5),
                      Text(
                        'The impact of the efforts of the association has been encouraging as more girls are opting for the profession, although the aggregate percentage is still quite low. In addition, the existence of APWEN has sensitized and created awareness in government, industries and the larger society. To this end, APWEN has embarked on continuous professional development for the technical industries and organizations with diverse participation, as our contribution to the technological development of the nation. A number of international bodies have shown interest in the activities of the association and APWEN has been invited to collaborate with UNESCO and the Global Alliance for diversifying of the workforce.',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.justify,
                      )
                    ]),
                  ),
                ],
              ),
              shadowColor: Color.fromRGBO(231, 190, 224, 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
      pageHeader: 'About APWEN',
      showMenu: true,
    );
  }

  _buildAbout(BuildContext context, String title, String content) {
    return Card(
      color: Color.fromRGBO(254, 233, 250, 1),
      elevation: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                height: 1.3,
                color: Color.fromRGBO(165, 54, 146, 1),
              ),
            ),
          ),
          Divider(
            color: Color.fromRGBO(165, 54, 146, 1),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
                color: Colors.black,
                height: 1.3,
              ),
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
      shadowColor: Color.fromRGBO(231, 190, 224, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  _buildBulletList(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 7),
        Container(
          margin: EdgeInsets.only(top: 5, right: 10),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Color.fromRGBO(165, 54, 146, 1)),
          height: 6,
          width: 6,
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              color: Colors.black,
              height: 1.3,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
