import 'dart:io';

import 'package:flutter/material.dart';
import 'package:than_pkg/than_pkg.dart';
import 'package:than_pkg/types/installed_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ThanPkg.instance.init(
    isShowDebugLog: true,
  );

  TRecentDB.init(rootPath: 'test.json');

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
      floatingActionButton: FloatingActionButton(
        // onPressed: _test,
        onPressed: () async {
          try {
            if (!await ThanPkg.platform.isStoragePermissionGranted()) {
              await ThanPkg.platform.requestStoragePermission();
            }
            // await TRecentDB.getInstance.putString('name', 'i am db name');
            // await TRecentDB.getInstance.putBool('isDark', true);
            // await TRecentDB.getInstance.putInt('age', 27);
            // await TRecentDB.getInstance.putDouble('height', 2.5);

            print(TRecentDB.getInstance.getString('name', def: 'def'));
          } catch (e) {
            debugPrint(e.toString());
          }
        },
        child: Icon(Icons.get_app),
      ),
    );
  }
}
