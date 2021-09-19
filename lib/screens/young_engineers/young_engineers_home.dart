import 'package:apwen/drawer.dart';
import 'package:apwen/screens/young_engineers/schedule_items/schedule.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class YoungEngineersHome extends StatelessWidget {
  static const String routeName = '/youngengineershome';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  YoungEngineersHome({Key? key}) : super(key: key);

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
                  Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 21),
              children: [
                TextSpan(text: 'Y'),
                TextSpan(text: 'O'),
                TextSpan(
                  text: 'U',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                TextSpan(text: 'N'),
                TextSpan(text: 'G'),
                TextSpan(text: '  '),
                TextSpan(text: 'E'),
                TextSpan(text: 'N'),
                TextSpan(text: 'G'),
                TextSpan(text: 'I'),
                TextSpan(
                  text: 'N',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                TextSpan(text: 'E'),
                TextSpan(text: 'E'),
                TextSpan(text: 'R'),
                TextSpan(text: 'S'),
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
      body: ListView(
        children: [
          SizedBox(height: 20),
          ListTile(
            title: Text(
              'Speakers',
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF1C293D),
                  fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              'See the speakers',
              style: TextStyle(fontSize: 17),
            ),
            leading: Icon(
              FontAwesomeIcons.microphone,
              size: 32,
              color: Theme.of(context).hintColor,
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Padding(
            padding: EdgeInsets.only(left: 70, right: 20),
            child: Divider(color: Colors.black, height: 10),
          ),
          ListTile(
            title: Text(
              'Panelists',
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF1C293D),
                  fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              'Check out the panelists',
              style: TextStyle(fontSize: 17),
            ),
            leading: Icon(
              FontAwesomeIcons.personBooth,
              size: 32,
              color: Theme.of(context).hintColor,
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Padding(
            padding: EdgeInsets.only(left: 70, right: 20),
            child: Divider(color: Colors.black, height: 10),
          ),
          ListTile(
            title: Text(
              'Schedule',
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF1C293D),
                  fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              'See the programme of event',
              style: TextStyle(fontSize: 17),
            ),
            leading: Icon(
              FontAwesomeIcons.calendarAlt,
              size: 32,
              color: Theme.of(context).hintColor,
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, YoungEngineersSchedule.routeName);
            },
          ),
        ],
      ),
    );
  }
}
