import 'dart:io';

import 'package:flutter/material.dart';
import 'package:than_pkg/than_pkg.dart';
import 'package:than_pkg/types/installed_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ThanPkg.instance.init(
    isShowDebugLog: true,
  );

  runApp(const MyApp());
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

    // MapServices.get<String>({}, ['name'], defaultValue: '');
    // MapServices.get<int>({}, ['num'], defaultValue: 1);
    // MapServices.get<double>({}, ['height'], defaultValue: 0.0);
    // //or
    // MapServices.get({}, ['keys'], defaultValue: ''); // -> type - auto cast
    // MapServices.get({
    //   'main': {'key': 'than'}
    // }, [
    //   'main',
    //   'key'
    // ], defaultValue: 'default name');

    // ThanPkg.appUtil.getParseMinutes(minutes);
    // ThanPkg.appUtil.copyText(text);
    // ThanPkg.appUtil.pasteText();
    // await ThanPkg.appUtil.clearImageCache();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark(),
      home: Scaffold(
        appBar: isFullScreen
            ? null
            : AppBar(
                title: const Text('test lib'),
              ),
        body: _getListWidget(),
        floatingActionButton: FloatingActionButton(
          // onPressed: _test,
          onPressed: () async {
            try {
              if (!await ThanPkg.platform.isStoragePermissionGranted()) {
                await ThanPkg.platform.requestStoragePermission();
              }
              appList = await ThanPkg.android.app.getInstalledAppsList();
              if (!mounted) return;
              setState(() {});
              // final outfile = await ThanPkg.platform.getAppExternalPath();
              // final stringBuff = StringBuffer('---app list---\n');
              // for (var app in list) {
              //   stringBuff.writeln('name: ${app.appName}');
              //   stringBuff.writeln('packageName: ${app.packageName}');
              //   stringBuff.writeln('versionName: ${app.versionName}');
              //   stringBuff.writeln('versionCode: ${app.versionCode}');
              //   stringBuff.writeln('---end---');
              // }
              // debugPrint(stringBuff.toString());

              // print('exported');
              // final list = await ThanPkg.android.app.getInstalledAppsList();
              // print(list.map((e) => e['packageName']).toList().join('\n'));
              // extension
              // final map = {'name': 'than', 'age': 29};
              // map.getString(['name-'], def: 'i def');
              // map.getBool(['isTrue']);
              // map.getDouble(['level']);
              // map.getInt(['age']);

              // final res = await ThanPkg.platform.getWifiAddressList();
              // final res = await ThanPkg.platform.getAppExternalPath();
              // final res = MapServices.getBool({'name': 134534}, ['name']);
              // ThanPkg.android.app
              //     .requestOrientation(type: ScreenOrientationTypes.portrait);
              // final res = await ThanPkg.platform.getWifiAddressList();
              // final res = MapServices.getString({'name':5},['name'],defaultValue: 'default name');
              // final res = MapServices.getDouble({},['name'],defaultValue: 0.5);
              // final res = MapServices.getInt({},['name'],defaultValue: 5);
              // final res =
              // MapServices.get({'name': 9.5}, ['name'], defaultValue: 'name');
              // final res = MapServices.get({
              //   'main': {'key': 'than'}
              // }, [
              //   'main',
              //   'keyk'
              // ], defaultValue: 'default name');
            } catch (e) {
              debugPrint(e.toString());
            }
          },
          child: Icon(Icons.get_app),
        ),
      ),
    );
  }

  Widget _getListWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: appList.length,
        itemBuilder: (context, index) {
          final item = appList[index];
          return Row(
            children: [
              item.coverData == null
                  ? SizedBox.shrink()
                  : SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.memory(item.coverData!)),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 3,
                      children: [
                        Text('appName: ${item.appName}'),
                        Text('packageName: ${item.packageName}'),
                        Text('versionName: ${item.versionName}'),
                        Text('versionCode: ${item.versionCode}'),
                        Text('Size: ${item.size!.getSizeLabel()}'),
                        IconButton(
                            onPressed: () async {
                              final outfile =
                                  await ThanPkg.platform.getAppExternalPath();
                              await item.export('$outfile/${item.appName}.apk');
                              debugPrint('saved');
                            },
                            icon: Icon(Icons.save))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
