import 'dart:io';

import 'package:flutter/material.dart';
import 'package:than_pkg/than_pkg.dart';
import 'package:than_pkg/types/installed_app.dart';

void main() async {
  await ThanPkg.instance.init(
    isShowDebugLog: true,
  );
  // class instance
  // final recent = TRecentDB()..setRootPath('test2.json');
  // // singleton
  // await TRecentDB.getInstance.init(rootPath: 'test.json');
  // // put && delete
  // await TRecentDB.getInstance.putString('name', 'thancoder');
  // await recent.putString('name', 'thancoder');
  // await recent.delete('name');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    init();
  }

  bool isFullScreen = false;
  String imageUri = '';
  final TextEditingController textEditingController = TextEditingController();
  List<InstalledApp> appList = [];

  void init() async {
    if (Platform.isAndroid) {
      await ThanPkg.android.app.toggleKeepScreenOn(isKeep: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('test lib'),
      ),
      body: Placeholder(),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
              heroTag: 'two',
              onPressed: () async {
                try {
                  final data = await ThanPkg.linux.ffmpeg.audio
                      .getAudioMetadata('/home/than/Music/test-meta.mp3');
                  print(data.toMap());
                } catch (e) {
                  debugPrint(e.toString());
                }
              }),
          FloatingActionButton(
              heroTag: 'one',
              onPressed: () async {
                try {
                  final inputPath = '/home/than/Music/test.mp3';
                  final outputPath = '/home/than/Music/test-meta.mp3';

                  // File('res.json')
                  //     .writeAsString(JsonEncoder.withIndent(' ').convert(res));
                  print('done');
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
              child: Icon(Icons.get_app)),
        ],
      ),
    );
  }
}
