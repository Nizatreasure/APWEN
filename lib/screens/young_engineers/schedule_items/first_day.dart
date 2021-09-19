import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class FirstDay extends StatefulWidget {
  FirstDay({Key? key}) : super(key: key);

  @override
  _FirstDayState createState() => _FirstDayState();
}

class _FirstDayState extends State<FirstDay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'FUN ACTIVITY',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                fontSize: 20),
          ),
          SizedBox(height: 25),
          TimelineTile(
            node: TimelineNode.simple(
              indicatorPosition: 0,
              color: Theme.of(context).hintColor.withOpacity(0.5),
              indicatorSize: 17,
            ),
            contents: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      '15:00 - 16:00',
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 23),
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    color: Color(0xfffffaf8),
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kayaking'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 12),
                          Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              Text(
                                'Resource Person:',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 8),
                              Text('Patricia Okoh')
                            ],
                          )
                        ],
                      ),
                    ),
                    shadowColor: Theme.of(context).textTheme.bodyText1?.color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            nodeAlign: TimelineNodeAlign.start,
          ),
        ],
      ),
    );
  }
}
