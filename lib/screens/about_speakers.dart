import 'package:apwen/page_decoration.dart';
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
    return PageDecoration(
      child: Column(
        children: [
          SizedBox(height: 30),
          Hero(
            tag: 'image$index',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Container(
                width: 200,
                height: 200,
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
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Divider(
            color: Color.fromRGBO(165, 54, 146, 1),
            height: 0,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 15),
              children: [
                Text(
                  aboutSpeaker.toString(),
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      pageHeader: 'Profile',
    );
  }
}
