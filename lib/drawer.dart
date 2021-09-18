import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:apwen/screens/home_page.dart';
import 'package:apwen/screens/sponsors.dart';
import 'package:apwen/screens/topics_speakers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:android_path_provider/android_path_provider.dart';

String selected = 'Home';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  ReceivePort _port = ReceivePort();

  registerDownloadPort() async {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      // String id = data[0];
      DownloadTaskStatus status = data[1];
      // int progress = data[2];

      if (status == DownloadTaskStatus.complete ||
          status == DownloadTaskStatus(3))
        Fluttertoast.showToast(
            msg: 'Download complete',
            backgroundColor: Color(0xFF1C293D),
            textColor: Colors.white);

      // setState(() {});
    });
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  downloadBrochure(String fileName, String url) async {
    String localPath;
    final status = await Permission.storage.request();
    if (status.isGranted) {
      var downloadPath = Platform.isAndroid
          ? Directory(await AndroidPathProvider.downloadsPath)
          : await getApplicationDocumentsDirectory();

      localPath = downloadPath.path;

      bool exists =
          await File(localPath + Platform.pathSeparator + fileName + '.pdf')
              .exists();

      if (!exists) {
        await FlutterDownloader.registerCallback(downloadCallback);
        await FlutterDownloader.enqueue(
            url: url,
            savedDir: localPath,
            fileName: fileName + '.pdf',
            showNotification: true,
            openFileFromNotification: true);
      } else {
        int? val = int.tryParse(
          fileName.substring(fileName.length - 1),
        );
        val = val == null ? 1 : val + 1;
        downloadBrochure(fileName + '$val', url);
      }
    } else
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please grant storage permission to download brochure',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFFF1592D),
        ),
      );
  }

  @override
  void initState() {
    registerDownloadPort();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black26,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: RawScrollbar(
                  thumbColor: Color(0xFF1C293D),
                  thickness: 3,
                  child: ListView(
                    children: [
                      GestureDetector(
                        onTap: () {
                          openUrl('https://www.apwen.org', context);
                        },
                        child: Container(
                          height: 140,
                          width: double.infinity,
                          color: Colors.black12,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(fontSize: 25),
                                  children: [
                                    TextSpan(text: 'A'),
                                    TextSpan(
                                      text: 'P',
                                    ),
                                    TextSpan(
                                        text: 'W',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).hintColor)),
                                    TextSpan(
                                      text: 'E',
                                    ),
                                    TextSpan(text: 'N\n'),
                                    TextSpan(text: 'Conference')
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            appDrawerButton(
                                name: 'Home', path: HomePage.routeName),
                            // SizedBox(height: 10),
                            // appDrawerButton(
                            //     name: 'Programme', path: HomePage.routeName),
                            SizedBox(height: 10),
                            appDrawerButton(
                                name: 'Topics & Speakers',
                                path: TopicsSpeakers.routeName),
                            SizedBox(height: 10),
                            appDrawerButton(
                                name: 'Sponsors', path: Sponsors.routeName),

                            // SizedBox(height: 10),
                            // appDrawerButton(
                            //     name: 'Topics', path: HomePage.routeName),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: double.infinity,
                color: Colors.black12.withOpacity(0.2),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.download, size: 20),
                  onPressed: () {
                    downloadBrochure('APWEN_conference_brochure',
                        'https://drive.google.com/uc?id=1ix06XCJHLnG1ouu8L1birNEV1R9hD6zh&export=download');
                  },
                  label: Text(
                    'Download Brochure',
                    style: TextStyle(fontSize: 17),
                  ),

                  // minWidth: double.infinity,
                ),
              ),
              Container(
                color: Colors.black12,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        openUrl(
                            'https://web.facebook.com/apwen.apwen.3', context);
                      },
                      icon: Icon(
                        FontAwesomeIcons.facebookF,
                        size: 30,
                        color: Color(0xff4267b2),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        openUrl('https://www.twitter.com/apwen_ng', context);
                      },
                      icon: Icon(
                        FontAwesomeIcons.twitter,
                        size: 30,
                        color: Color(0xff1da1f2),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        openUrl(
                            'https://www.linkedin.com/in/apwen-national-hq-8440b369',
                            context);
                      },
                      icon: Icon(
                        FontAwesomeIcons.linkedinIn,
                        size: 30,
                        color: Color(0xff0077b5),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        openUrl(
                            'https://www.instagram.com/apwennational', context);
                      },
                      icon: Icon(
                        FontAwesomeIcons.instagram,
                        size: 30,
                        color: Color(0xffcd486b),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        openUrl(
                            'https://youtube.com/channel/UC6tgFLmOTb1IGzYiFDgB9MQ',
                            context);
                      },
                      icon: Icon(
                        FontAwesomeIcons.youtube,
                        size: 30,
                        color: Color(0xffff0000),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  appDrawerButton({required String name, required String path}) {
    return TextButton(
      onPressed: () {
        if (selected == name) {
          Navigator.pop(context);
        } else {
          setState(() {
            selected = name;
          });
          Navigator.of(context).pushReplacementNamed(
            path,
          );
        }
      },
      style: Theme.of(context).textButtonTheme.style,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            border: selected == name
                ? Border.all(
                    color: Color(0xFF1C293D),
                  )
                : null,
            borderRadius: BorderRadius.circular(8)),
        child: Text(
          name,
          style: Theme.of(context).textTheme.button?.copyWith(fontSize: 22),
        ),
      ),
    );
  }
}

Future<void> openUrl(String url, BuildContext context) async {
  if (await canLaunch(url))
    launch(url);
  else
    showError(context);
}

Future<void> showError(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.brown[300],
          content: Text(
            'Could not launch application',
            style: TextStyle(color: Colors.brown[800]),
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.brown[900], fontSize: 16),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}
