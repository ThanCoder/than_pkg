import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:than_pkg/terminal_app/ffmpeg/audio_metadata.dart';
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
                  final data = await ThanPkg.linux.ffmpeg.ffprob
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
                  
                  // await ThanPkg.linux.ffmpeg.videoToAudio(
                  //   videoPath: path,
                  //   outputPath: path2,
                  //   // bitrate: AudioBitrate.k320,
                  //   onStdout: (data) {
                  //     print(data);
                  //   },
                  // );
                  // await ThanPkg.linux.ffmpeg.video.videoToGif(
                  //   inputPath: inputPath,
                  //   outputPath: outputPath,
                  //   duration: Duration(seconds: 5),
                  //   onStdout: (data) {
                  //     print(data);
                  //   },
                  // );
                  // await ThanPkg.linux.ffmpeg.video.changeResolution(
                  //   inputPath: inputPath,
                  //   outputPath: outputPath,
                  //   resolution: VideoResolutionSize.p360,
                  //   onStdout: (data) {
                  //     print(data);
                  //   },
                  // );

                  // await ThanPkg.linux.ffmpeg.ffprob.editAudioMetadata(
                  //     inputPath: inputPath,
                  //     outputPath: outputPath,
                  //     metadata: AudioMetadata(title: 'test one'));
                  // await ThanPkg.linux.ffmpeg.ffprob.addAudioThumbnail(
                  //   audioPath: inputPath,
                  //   imagePath: '/home/than/Music/cover.png',
                  //   outputPath: outputPath,
                  //   onStdout: (data) {
                  //     print(data);
                  //   },
                  // );
                  // File('res.json')
                  //     .writeAsString(JsonEncoder.withIndent(' ').convert(res));
                  print('done');
                  // ThanPkg.linux.ffmpeg
                  // List<String> abiList = await ThanPkg.android.app.getABI();
                  // ThanPkg.platform.getABI()
                  // ThanPkg.android.app.setWallpaper(path: path)
                  // if (!await ThanPkg.platform.isStoragePermissionGranted()) {
                  //   await ThanPkg.platform.requestStoragePermission();
                  // }
                  // await TRecentDB.getInstance.putString('name', 'i am db name');
                  // await TRecentDB.getInstance.putBool('isDark', true);
                  // await TRecentDB.getInstance.putInt('age', 27);
                  // await TRecentDB.getInstance.putDouble('height', 2.5);

                  // print(TRecentDB.getInstance.getString('name', def: 'def'));
                  // print(AndroidSettings.ACTION_SETTINGS);

                  // await ThanPkg.android.intent.shareUrl(url: 'https://github.com/');
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
