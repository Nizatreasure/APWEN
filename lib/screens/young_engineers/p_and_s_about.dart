import 'package:flutter/material.dart';

class YoungEngineersPAndSAbout extends StatelessWidget {
  static const String routeName = '/youngengineerspandsabout';
  final int index;
  final String path;
  final String name;
  final List about;
  final List subAbout;
  const YoungEngineersPAndSAbout(
      {Key? key,
      required this.index,
      required this.path,
      required this.name,
      required this.about,
      required this.subAbout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                alignment: Alignment.topCenter,
                height: 0.6 * width + 70,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 0.6 * width,
                          width: double.infinity,
                          child: Image.asset(
                            'assets/$path',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: 0.6 * width,
                          width: double.infinity,
                          color: Colors.white38,
                        ),
                        Container(
                          height: 0.6 * width,
                          width: double.infinity,
                          color: Colors.black.withOpacity(0.75),
                        ),
                        Positioned(
                          top: 20,
                          left: 15,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white54),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Color(0xFF1C293D),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Hero(
                  tag: 'image$index',
                  child: Container(
                    height: 200,
                    width: 170,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFF1592D), width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Image.asset(
                        'assets/$path',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 20),
                Text('About',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 23, color: Theme.of(context).hintColor)),
                SizedBox(height: 12),
                Column(
                  children: about.map((e) => _buildBulletList(e)).toList(),
                ),
                SizedBox(height: 7),
                if (subAbout.isNotEmpty)
                  Column(
                    children: subAbout.map((e) => _buildSubAbout(e)).toList(),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubAbout(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 15, bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '—',
            style: TextStyle(color: Color(0xFF1C293D)),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.normal, height: 1.2, fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletList(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 7),
          Container(
            margin: EdgeInsets.only(top: 8, right: 10),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0xFF1C293D)),
            height: 10,
            width: 10,
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.normal, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
