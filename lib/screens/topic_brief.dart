import 'dart:io';

import 'package:apwen/screens/about_speakers.dart';
import 'package:apwen/screens/comments.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopicBrief extends StatefulWidget {
  static const routeName = '/topicbrief';
  final int index;
  final String aboutSpeaker;
  final String aboutTopic;
  final String image;
  final String name;
  final String topic;
  final int id;
  TopicBrief(
      {Key? key,
      required this.index,
      required this.aboutSpeaker,
      required this.aboutTopic,
      required this.id,
      required this.image,
      required this.topic,
      required this.name})
      : super(key: key);

  @override
  _TopicBriefState createState() => _TopicBriefState();
}

class _TopicBriefState extends State<TopicBrief> {
  late TextEditingController _commentController;
  late TextEditingController _nameController;
  late SharedPreferences pref;
  String name = '';

  initSharedPrefs() async {
    pref = await SharedPreferences.getInstance();
    bool exists = pref.containsKey('name');
    if (exists) {
      name = pref.getString('name')!;
    }
  }

  @override
  void initState() {
    _commentController = TextEditingController();
    _nameController = TextEditingController();
    initSharedPrefs();
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            currentFocus.focusedChild?.unfocus();
          },
          child: LayoutBuilder(
            builder: (context, viewport) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewport.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
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
                                        child: CachedNetworkImage(
                                          imageUrl: widget.image,
                                          fit: BoxFit.cover,
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
                                              shape: BoxShape.circle,
                                              color: Colors.white54),
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
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AboutSpeaker.routeName,
                                      arguments: {
                                        'index': widget.index,
                                        'name': widget.name,
                                        'aboutSpeakers': widget.aboutSpeaker,
                                        'image': widget.image
                                      });
                                },
                                child: Hero(
                                  tag: 'image${widget.index}',
                                  child: Container(
                                    height: 200,
                                    width: 170,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFF1592D), width: 2),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(9),
                                      child: CachedNetworkImage(
                                        imageUrl: widget.image,
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
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Text(
                                  widget.name,
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(height: 20),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Theme',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                            fontSize: 23,
                                            fontFamily: 'Lato',
                                            color: Theme.of(context).hintColor,
                                            letterSpacing: 1),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      widget.topic.isEmpty
                                          ? 'Women Engineers Driving Digital Transformation in Nigeria'
                                          : widget.topic,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontFamily: 'Montserrat')),
                                ),
                                SizedBox(height: 20),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.aboutTopic,
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.color
                                            ?.withOpacity(0.7),
                                        height: 1.4),
                                  ),
                                ),
                                SizedBox(height: 50),
                                Spacer(),
                                TextField(
                                  minLines: 6,
                                  maxLines: 6,
                                  controller: _commentController,
                                  autofocus: false,
                                  style: TextStyle(fontFamily: 'Lato'),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Color(0xFF1C293D),
                                      ),
                                    ),
                                    filled: true,
                                    hintText: 'Leave a comment',
                                    hintStyle: TextStyle(),
                                    fillColor: Colors.black12,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Color(0xFF1C293D),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        FocusScope.of(context)
                                            .focusedChild
                                            ?.unfocus();
                                        Navigator.pushNamed(
                                            context, Comments.routeName,
                                            arguments: {'id': widget.id});
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color(0xFF1C293D),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          'View Comments',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF1C293D),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    TextButton(
                                      onPressed: () {
                                        FocusScope.of(context)
                                            .focusedChild
                                            ?.unfocus();
                                        if (_commentController.text
                                            .trim()
                                            .isNotEmpty) {
                                          if (name.isEmpty)
                                            showNameDialog();
                                          else {
                                            sendMessage(
                                                _commentController.text.trim(),
                                                name);
                                            setState(() {
                                              _commentController.text = '';
                                            });
                                          }
                                        }
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Color(0xFFF1592D),
                                        ),
                                      ),
                                      child: Text(
                                        'Send',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20)
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  sendMessage(String message, String name) async {
    await FirebaseFirestore.instance
        .collection('Comments')
        .doc('Comments')
        .collection(widget.id.toString())
        .add({'message': message, 'name': name, 'timestamp': Timestamp.now()});
  }

  showNameDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.black87,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextField(
                  controller: _nameController,
                  autofocus: true,
                  cursorHeight: 20,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    counterText: '',
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: 'Please enter name',
                  ),
                  textCapitalization: TextCapitalization.words,
                  style: TextStyle(color: Colors.white),
                  maxLength: 15,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'Lato',
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(width: 40),
                    TextButton(
                      onPressed: () async {
                        if (_nameController.text.trim().isNotEmpty) {
                          pref.setString('name', _nameController.text.trim());
                          name = _nameController.text.trim();
                          sendMessage(_commentController.text.trim(),
                              _nameController.text.trim());
                          _commentController.text = '';
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                      child: Text(
                        'Done',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lato',
                            fontSize: 16),
                      ),
                    ),
                  ],
                )
              ]),
            ),
          );
        });
  }
}
