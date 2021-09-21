import 'package:apwen/drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

class Sponsors extends StatefulWidget {
  static const routeName = '/sponsors';
  Sponsors({Key? key}) : super(key: key);

  @override
  _SponsorsState createState() => _SponsorsState();
}

class _SponsorsState extends State<Sponsors> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double currentSponsor = 0;
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
                  Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 22),
              children: [
                TextSpan(text: 'A'),
                TextSpan(text: 'P'),
                TextSpan(
                  text: 'W',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                TextSpan(text: 'E'),
                TextSpan(text: 'N'),
                TextSpan(text: '  '),
                TextSpan(text: 'S'),
                TextSpan(text: 'P'),
                TextSpan(text: 'O'),
                TextSpan(text: 'N'),
                TextSpan(text: 'S'),
                TextSpan(text: 'O'),
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
          ),
        ],
      ),
      endDrawer: AppDrawer(),
      body: LayoutBuilder(builder: (context, viewport1) {
        return Column(
          children: [
            Container(
              child: CarouselSlider(
                items: [1, 2, 3, 4, 5]
                    .map(
                      (e) => Image.asset(
                        'assets/sponsors/$e.jpg',
                        fit: BoxFit.contain,
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                    autoPlay: true,
                    enableInfiniteScroll: true,
                    height: viewport1.maxHeight - viewport1.maxHeight * 0.2,
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    onPageChanged: (num, _) {
                      setState(() {
                        currentSponsor = num.toDouble();
                      });
                    }),
              ),
            ),
            SizedBox(height: 10),
            DotsIndicator(
              dotsCount: 5,
              position: currentSponsor,
              decorator: DotsDecorator(
                activeColor: Color(0xFFF1592D),
                color: Color(0xFF1C293D),
                size: Size.square(10),
                activeSize: Size.square(14),
                spacing: EdgeInsets.all(8),
              ),
            ),
          ],
        );
      }),
    );
  }
}
