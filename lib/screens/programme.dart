import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:apwen/drawer.dart';
import 'package:apwen/page_decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Programme extends StatefulWidget {
  static const routeName = '/programme';
  Programme({Key? key}) : super(key: key);

  @override
  _ProgrammeState createState() => _ProgrammeState();
}

class _ProgrammeState extends State<Programme> {
  ReceivePort _port = ReceivePort();

  registerDownloadPort() async {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen(
      (dynamic data) {
        DownloadTaskStatus status = data[1];
        int progress = data[2];
        progress = progress < 0 ? 0 : progress;

        if (status == DownloadTaskStatus.complete ||
            status == DownloadTaskStatus(3)) {
          if (mounted) showOpenDialog(data[0]);
        }
      },
    );
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  downloadFiles(String fileName, String url, {String? holder}) async {
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
        print(holder);
        int? val = int.tryParse(fileName
            .substring(holder == null ? fileName.length - 1 : holder.length));
        holder = holder == null ? fileName : holder;

        print('val is $val');
        val = val == null ? 1 : val + 1;
        val == 1
            ? downloadFiles(fileName + '$val', url, holder: holder)
            : downloadFiles(fileName.substring(0, holder.length) + '$val', url,
                holder: holder);
      }
    } else
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please grant storage permission to download file',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontSize: 16.5,
            ),
          ),
          backgroundColor: Color.fromRGBO(165, 54, 146, 1),
        ),
      );
  }

  @override
  void initState() {
    registerDownloadPort();
    super.initState();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageDecoration(
      showMenu: true,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('resources')
              .orderBy('title')
              .snapshots(),
          builder: (context, snapshot) {
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
                  'No Programme',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                  ),
                ),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                QueryDocumentSnapshot currentData = snapshot.data!.docs[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        currentData['title'],
                        style: TextStyle(
                          fontSize: 16.5,
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: currentData['subtitle'] != null
                          ? Text(
                              currentData['subtitle'],
                              style: TextStyle(
                                fontSize: 13.5,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : null,
                      leading: Icon(
                        FontAwesomeIcons.filePdf,
                        size: 32,
                        color: Color.fromRGBO(165, 54, 146, 1),
                      ),
                      onTap: () async {
                        String viewUrl = currentData['viewUrl'] ?? '';
                        String downloadUrl = currentData['downloadUrl'] ?? '';
                        showMessageDialog(
                          fileName: currentData['title'],
                          downloadUrl: downloadUrl,
                          viewUrl: viewUrl,
                        );
                      },
                    ),
                    if (index != snapshot.data!.docs.length - 1)
                      Padding(
                        padding: EdgeInsets.only(left: 70, right: 20),
                        child: Divider(
                            color: Color.fromRGBO(165, 54, 146, 1), height: 10),
                      ),
                  ],
                );
              },
              itemCount: snapshot.data!.docs.length,
              padding: EdgeInsets.symmetric(vertical: 20),
            );
          }),
      pageHeader: 'Programme',
    );
  }

  showMessageDialog(
      {required String fileName,
      required String viewUrl,
      required String downloadUrl}) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Color.fromRGBO(217, 217, 217, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                child: Text(
                  fileName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      openUrl(viewUrl, context);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: Color.fromRGBO(165, 54, 146, 1),
                            )),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'View',
                        style: TextStyle(
                          fontSize: 17,
                          color: Color.fromRGBO(165, 54, 146, 1),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      downloadFiles(fileName.split(' ').join('_'), downloadUrl);
                      Fluttertoast.showToast(
                        msg: 'Download started',
                        backgroundColor: Color.fromRGBO(165, 54, 146, 1),
                        textColor: Colors.white,
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(165, 54, 146, 1),
                      ),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Download',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10)
            ],
          ),
        );
      },
    );
  }

  showOpenDialog(String id) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Color.fromRGBO(217, 217, 217, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                child: Text(
                  'Download Complete',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: Color.fromRGBO(165, 54, 146, 1),
                            )),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Close',
                        style: TextStyle(
                          fontSize: 17,
                          color: Color.fromRGBO(165, 54, 146, 1),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      FlutterDownloader.open(taskId: id);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(165, 54, 146, 1),
                      ),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Open',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
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
