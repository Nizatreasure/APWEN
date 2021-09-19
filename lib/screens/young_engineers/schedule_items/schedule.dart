import 'package:apwen/screens/young_engineers/schedule_items/first_day.dart';
import 'package:apwen/screens/young_engineers/schedule_items/other_days.dart';
import 'package:flutter/material.dart';

class YoungEngineersSchedule extends StatefulWidget {
  static const String routeName = '/youngengineersschedule';
  YoungEngineersSchedule({Key? key}) : super(key: key);

  @override
  _YoungEngineersScheduleState createState() => _YoungEngineersScheduleState();
}

class _YoungEngineersScheduleState extends State<YoungEngineersSchedule>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      // setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).hintColor,
          labelStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
          labelColor: Theme.of(context).hintColor,
          unselectedLabelColor: Theme.of(context).textTheme.bodyText1?.color,
          unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              fontFamily: 'Montserrat'),
          tabs: [
            Tab(
              child: Text('20/09'),
              // text: '20/09',
            ),
            Tab(
              child: Text('21/09'),
            ),
            Tab(
              child: Text('22/09'),
            ),
            Tab(
              child: Text('23/09'),
            ),
          ],
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 5, top: 5),
          child: RichText(
            text: TextSpan(
              style:
                  Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 21),
              children: [
                TextSpan(text: 'S'),
                TextSpan(text: 'C'),
                TextSpan(text: 'H'),
                TextSpan(
                  text: 'E',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                TextSpan(text: 'D'),
                TextSpan(text: 'U'),
                TextSpan(text: 'L'),
                TextSpan(text: 'E'),
              ],
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).hintColor,
          ),
        ),
        elevation: 0,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FirstDay(),
          OtherDays('day_two'),
          OtherDays('day_three'),
          OtherDays('day_four'),
        ],
      ),
    );
  }
}
