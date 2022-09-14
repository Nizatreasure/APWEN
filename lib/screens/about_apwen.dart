import 'package:apwen/drawer.dart';
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

  Future<void> openUrl(String url, BuildContext context) async {
    if (await canLaunchUrl(Uri.parse(url)))
      launchUrl(Uri.parse(url));
    else
      showError(context);
  }

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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 5, top: 5),
          child: RichText(
            text: TextSpan(
              style:
                  Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20),
              children: [
                TextSpan(text: 'A'),
                TextSpan(text: 'B'),
                TextSpan(
                  text: 'O',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                TextSpan(text: 'U'),
                TextSpan(text: 'T'),
                TextSpan(text: '  '),
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
        ),
        automaticallyImplyLeading: false,
        elevation: 1,
        toolbarHeight: 65,
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
      body: WillPopScope(
        onWillPop: () async {
          selected = HomePage.routeName;
          Navigator.pushReplacementNamed(context, HomePage.routeName);
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      children: [
                        TextSpan(text: 'For more information, visit'),
                        TextSpan(
                            text: ' www.apwen.org',
                            style: TextStyle(color: Colors.blue),
                            recognizer: _gestureRecognizer),
                      ]),
                ),
              ),
              SizedBox(height: 10),
              _buildAbout(context, 'Our History',
                  'The Association of Professional Women Engineers of Nigeria APWEN was formed by a handful of women engineers led by Engr. (Mrs.) J. O. Maduka in 1982 and was formally inaugurated in 1983. It was originally meant to be a pressure group since most men hiring engineers then would rather have women in the kitchen and not on construction sites or behind the desk carrying out engineering designs.'),
              SizedBox(height: 10),
              Card(
                color: Colors.white,
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What We Do',
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Since 1982, APWEN has recorded a level of achievement of her objectives by advancing professional knowledge of members through:',
                        style: TextStyle(
                            fontWeight: FontWeight.normal, height: 1.3),
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
                            fontWeight: FontWeight.normal, height: 1.3),
                      )
                    ],
                  ),
                ),
                shadowColor: Theme.of(context).textTheme.bodyText1?.color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }

  _buildAbout(BuildContext context, String title, String content) {
    return Card(
      color: Colors.white,
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  height: 1.3),
            ),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
      shadowColor: Theme.of(context).textTheme.bodyText1?.color,
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
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Color(0xFF1C293D)),
          height: 10,
          width: 10,
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.normal, height: 1.3),
          ),
        ),
      ],
    );
  }
}
