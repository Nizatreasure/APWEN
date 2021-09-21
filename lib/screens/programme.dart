import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:apwen/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart';

class Programme extends StatefulWidget {
  static const routeName = '/programme';
  Programme({Key? key}) : super(key: key);

  @override
  _ProgrammeState createState() => _ProgrammeState();
}

class _ProgrammeState extends State<Programme> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ReceivePort _port = ReceivePort();

  registerDownloadPort() async {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen(
      (dynamic data) {
        // String id = data[0];
        DownloadTaskStatus status = data[1];
        int progress = data[2];
        progress = progress < 0 ? 0 : progress;

        if (status == DownloadTaskStatus.complete ||
            status == DownloadTaskStatus(3))
          Fluttertoast.showToast(
              msg: 'Download complete',
              backgroundColor: Color(0xFF1C293D),
              textColor: Colors.white);

        // setState(() {});
      },
    );
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  downloadFiles(String fileName, String url) async {
    String localPath;
    final status = await Permission.storage.request();
    if (status.isGranted) {
      var downloadPath = Platform.isAndroid
          ? Directory(await AndroidPathProvider.downloadsPath)
          : await getApplicationDocumentsDirectory();

      localPath = downloadPath.path;
      print(localPath);

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
        val == 1
            ? downloadFiles(fileName + '$val', url)
            : downloadFiles(
                fileName.substring(0, fileName.length - 1) + '$val', url);
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

  Future<void> openUrl(String url, BuildContext context) async {
    if (await canLaunch(url))
      launch(url);
    else
      showError(context);
  }

  @override
  void initState() {
    registerDownloadPort();
    super.initState();
  }

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
                TextSpan(text: 'P'),
                TextSpan(text: 'R'),
                TextSpan(text: 'O'),
                TextSpan(text: 'G'),
                TextSpan(
                  text: 'R',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                TextSpan(text: 'A'),
                TextSpan(text: 'M'),
                TextSpan(text: 'M'),
                TextSpan(text: 'E'),
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
          SizedBox(height: 25),
          ListTile(
            title: Text(
              'APWEN 2021 Brochure',
              style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF1C293D),
                  fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              'Get the brochure for the event',
              style: TextStyle(fontSize: 17),
            ),
            leading: Icon(
              FontAwesomeIcons.filePdf,
              size: 32,
              color: Theme.of(context).hintColor,
            ),
            onTap: () async {
              showBusyIndicator();
              try {
                final response = await get(
                  Uri.parse('https://www.google.com'),
                );
                if (response.statusCode == 200) {
                  DocumentSnapshot doc = await FirebaseFirestore.instance
                      .collection('resources')
                      .doc('brochure')
                      .get();
                  String viewUrl = doc['viewUrl'] ?? '';
                  String downloadUrl = doc['downloadUrl'] ?? '';
                  Navigator.pop(context);
                  showMessageDialog(
                      fileName: 'brochure',
                      downloadUrl: downloadUrl,
                      viewUrl: viewUrl);
                } else {
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg:
                          'Failed to get resources. Check your internet connection and try again',
                      backgroundColor: Color(0xFF1C293D),
                      textColor: Colors.white,
                      toastLength: Toast.LENGTH_LONG);
                }
              } catch (e) {
                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg:
                        'Failed to get resources. Check your internet connection and try again',
                    backgroundColor: Color(0xFF1C293D),
                    textColor: Colors.white,
                    toastLength: Toast.LENGTH_LONG);
              }
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 70, right: 20),
            child: Divider(color: Colors.black, height: 10),
          ),
          ListTile(
            title: Text(
              'APWEN 2021 Programme of Event',
              style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF1C293D),
                  fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              'Get the programme of event',
              style: TextStyle(fontSize: 17),
            ),
            leading: Icon(
              FontAwesomeIcons.filePdf,
              size: 32,
              color: Theme.of(context).hintColor,
            ),
            onTap: () async {
              showBusyIndicator();
              try {
                final response = await get(
                  Uri.parse('https://www.google.com'),
                );
                if (response.statusCode == 200) {
                  DocumentSnapshot doc = await FirebaseFirestore.instance
                      .collection('resources')
                      .doc('programme')
                      .get();
                  String viewUrl = doc['viewUrl'] ?? '';
                  String downloadUrl = doc['downloadUrl'] ?? '';
                  Navigator.pop(context);
                  showMessageDialog(
                      fileName: 'programme of event',
                      downloadUrl: downloadUrl,
                      viewUrl: viewUrl);
                } else {
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg:
                          'Failed to get resources. Check your internet connection and try again',
                      backgroundColor: Color(0xFF1C293D),
                      textColor: Colors.white,
                      toastLength: Toast.LENGTH_LONG);
                }
              } catch (e) {
                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg:
                        'Failed to get resources. Check your internet connection and try again',
                    backgroundColor: Color(0xFF1C293D),
                    textColor: Colors.white,
                    toastLength: Toast.LENGTH_LONG);
              }
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 70, right: 20),
            child: Divider(color: Colors.black, height: 10),
          ),
          ListTile(
            title: Text(
              'APWEN 2021 Schedule for Technical Session',
              style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF1C293D),
                  fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              'Get the schedule for technical session',
              style: TextStyle(fontSize: 17),
            ),
            leading: Icon(
              FontAwesomeIcons.filePdf,
              size: 32,
              color: Theme.of(context).hintColor,
            ),
            onTap: () async {
              showBusyIndicator();
              try {
                final response = await get(
                  Uri.parse('https://www.google.com'),
                );
                if (response.statusCode == 200) {
                  DocumentSnapshot doc = await FirebaseFirestore.instance
                      .collection('resources')
                      .doc('schedule')
                      .get();
                  String viewUrl = doc['viewUrl'] ?? '';
                  String downloadUrl = doc['downloadUrl'] ?? '';
                  Navigator.pop(context);
                  showMessageDialog(
                      fileName: 'schedule for technical session',
                      downloadUrl: downloadUrl,
                      viewUrl: viewUrl);
                } else {
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg:
                          'Failed to get resources. Check your internet connection and try again',
                      backgroundColor: Color(0xFF1C293D),
                      textColor: Colors.white,
                      toastLength: Toast.LENGTH_LONG);
                }
              } catch (e) {
                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg:
                        'Failed to get resources. Check your internet connection and try again',
                    backgroundColor: Color(0xFF1C293D),
                    textColor: Colors.white,
                    toastLength: Toast.LENGTH_LONG);
              }
            },
          ),
        ],
      ),
    );
  }

  showBusyIndicator() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('Getting resources. Please wait...'),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  ),
                )
              ],
            ),
          );
        });
  }

  showMessageDialog(
      {required String fileName,
      required String viewUrl,
      required String downloadUrl}) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white60,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                child: Text('View or download the $fileName'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF1C293D),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF1C293D),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (viewUrl.isNotEmpty)
                        openUrl(viewUrl, context);
                      else
                        Fluttertoast.showToast(
                            msg: 'Link unavailable. Try again later',
                            backgroundColor: Color(0xFF1C293D),
                            textColor: Colors.white,
                            toastLength: Toast.LENGTH_LONG);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.blue[700],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Download',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     if (downloadUrl.isNotEmpty) {
                  //       Navigator.pop(context);
                  //       Fluttertoast.showToast(
                  //           msg: 'Downloading',
                  //           backgroundColor: Color(0xFF1C293D),
                  //           textColor: Colors.white,
                  //           toastLength: Toast.LENGTH_LONG);
                  //       downloadFiles(
                  //           'APWEN_Conference_' + fileName.split(' ').join('_'),
                  //           downloadUrl);
                  //     } else
                  //       Fluttertoast.showToast(
                  //           msg: 'Link unavailable. Try again later',
                  //           backgroundColor: Color(0xFF1C293D),
                  //           textColor: Colors.white,
                  //           toastLength: Toast.LENGTH_LONG);
                  //   },
                  //   style: ButtonStyle(
                  //     backgroundColor: MaterialStateProperty.all(
                  //       Colors.blue,
                  //     ),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.fromLTRB(10, 10, 15, 10),
                  //     child: Text(
                  //       'Download',
                  //       style: TextStyle(fontSize: 18, color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 10)
            ],
          ),
        );
      },
    );
  }
}
