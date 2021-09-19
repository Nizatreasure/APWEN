import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AboutSpeaker extends StatelessWidget {
  static const routeName = '/aboutspeakers';
  final int index;
  final String aboutSpeaker;
  final String image;
  final String name;
  const AboutSpeaker(
      {Key? key,
      required this.aboutSpeaker,
      required this.name,
      required this.image,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 5, top: 5),
          child: RichText(
            text: TextSpan(
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontSize: 23),
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
                ]),
          ),
        ),
        elevation: 0,
      ),
      body: ListView(
        children: [
          SizedBox(height: 30),
          Stack(
            children: [
              Hero(
                tag: 'image$index',
                child: ClipRRect(
                  child: Container(
                    width: width,
                    height: width - width / 4,
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      errorWidget: (context, _, __) {
                        return Center(
                          child: Icon(
                            Icons.error,
                            size: 38,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   bottom: 0,
              //   left: 0,
              //   right: 0,
              //   height: 50,
              //   child: Container(
              //     decoration: BoxDecoration(
              //       gradient: LinearGradient(
              //         colors: [Colors.black, Colors.white10],
              //         begin: Alignment.topCenter,
              //         end: Alignment.bottomCenter,
              //       ),
              //     ),
              //     alignment: Alignment.center,
              //     child: Text('Undie Ebenezer Unimakpel',
              //         style: Theme.of(context)
              //             .textTheme
              //             .bodyText2
              //             ?.copyWith(fontSize: 20)),
              //   ),
              // ),
            ],
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              name,
              style: TextStyle(fontSize: 25),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('About',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 23, color: Theme.of(context).hintColor)),
                SizedBox(height: 12),
                Text(
                  aboutSpeaker,
                  style: TextStyle(fontSize: 17, fontFamily: 'Lato'),
                ),
                SizedBox(height: 20)
              ],
            ),
          )
        ],
      ),
    );
  }
}
