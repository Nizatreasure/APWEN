import 'package:apwen/page_decoration.dart';
import 'package:apwen/screens/young_engineers/schedule_items/other_days.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    super.initState();
  }

  registerController(int length) {
    _tabController = TabController(length: length, vsync: this);
    _tabController.removeListener(() {});
    _tabController.addListener(() {});
  }

  // doThis() async {
  //   QuerySnapshot data = await FirebaseFirestore.instance
  //       .collection('young_engineers')
  //       .doc('young_engineers')
  //       .collection('day_six')
  //       .get();

  //   data.docs.forEach((element) {
  //     Map<String, dynamic> items = element.data() as Map<String, dynamic>;
  //     FirebaseFirestore.instance
  //         .collection('young_engineers')
  //         .doc('day_six')
  //         .collection('day_six')
  //         .add(items);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // doThis();
    return PageDecoration(
      pageHeader: 'Event Schedule',
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('young_engineers')
              .orderBy('date')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.none ||
                snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    Color.fromRGBO(165, 54, 146, 1),
                  ),
                  strokeWidth: 5,
                ),
              );
            if (!(snapshot.hasData) || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'No Schedule',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                  ),
                ),
              );
            }
            List<QueryDocumentSnapshot> schedule = snapshot.data!.docs;
            registerController(schedule.length);

            return Scaffold(
              appBar: AppBar(
                title: TabBar(
                  controller: _tabController,
                  indicatorColor: Color.fromRGBO(165, 54, 146, 1),
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  labelColor: Color.fromRGBO(165, 54, 146, 1),
                  unselectedLabelColor: Colors.black,
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                  ),
                  tabs: schedule
                      .map((e) => Tab(
                            text: e['date'],
                          ))
                      .toList(),
                ),
                titleSpacing: 0,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                elevation: 0,
              ),
              body: TabBarView(
                controller: _tabController,
                children: schedule.map((e) => OtherDays(e.id)).toList(),
              ),
            );
          }),
    );
  }
}
