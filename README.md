## My personal Flutter plugin with support for both Android and Linux platforms

## ThanPkg V3.1.4

# Needed lib for linux

```bash
sudo apt install net-tools  // wifi
sudo apt install poppler-utils //pdf thumbnail
sudo apt install ffmpeg //video thumbnail
```

# Platforms Methods

- `ThanPkg.platform.*`
- `ThanPkg.platform.checkScreenOrientation`
- `ThanPkg.platform.genPdfThumbnail`
- `ThanPkg.platform.genVideoThumbnail`
- `ThanPkg.platform.getAppBatteryLevel`
- `ThanPkg.platform.getDeviceId`

# Linux

- `ThanPkg.linux.*`

# Android

- `ThanPkg.android.*`

### TMap

```Dart
//class
TMap
// extension
final map = {'name': 'than', 'age': 29};
map.getString(['name-'], def: 'i def');
map.getBool(['isTrue']);
map.getDouble(['level']);
map.getInt(['age']);
```

### TJsonDatabase

```Dart
class Person {}

class PerDB extends TJsonDatabase<Person> {
  PerDB({required super.path});

  @override
  Person fromMap(Map<String, dynamic> map) {
    // TODO: implement fromMap
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toMap(Person value) {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
final db = PerDB(path: 'path');
```

### TDatabase

```Dart
class Person {}

class PerIO extends DataIO {
  @override
  Future<String> read(String source) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<void> write(String source, String data) {
    // TODO: implement write
    throw UnimplementedError();
  }
}
// or you can use TJsonConverter
class PerConverter2 extends JsonConverter<Person>{
  @override
  Person from(Map<String, dynamic> value) {
    // TODO: implement from
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> to(Person value) {
    // TODO: implement to
    throw UnimplementedError();
  }
}

class PerConverter extends TConverter<Person, Map<String, dynamic>> {
  @override
  Person from(Map<String, dynamic> value) {
    // TODO: implement from
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> to(Person value) {
    // TODO: implement to
    throw UnimplementedError();
  }
}

class PerDB extends TDatabase<Person> {
  PerDB({
    required super.io,
    required super.converter,
    required super.databasePath,
  });

  @override
  Future<void> add(Person value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> delete(Person value) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Person>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<void> update(Person value) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

final db = PerDB(io: PerIO(), converter: PerConverter(), databasePath: '');
```

### TDatabase Listener

```Dart
class _MyAppState extends State<MyApp> with TDatabaseListener {
  @override
  void initState() {
    db.addListener(this);
    super.initState();
    init();
  }

  @override
  void dispose() {
    db.removeListener(this);
    super.dispose();
  }

  @override
  void onDatabaseChanged() {
    // TODO: implement onDatabaseChanged
  }
}
```

### Map Services

```Dart
//new
MapServices.getBool({}, ['name'])
MapServices.getInt({}, ['name'])
MapServices.getString({}, ['name'])
MapServices.getDouble({}, ['name'])
//old
MapServices.get<String>({}, ['name'], defaultValue: '');
MapServices.get<int>({}, ['num'], defaultValue: 1);
MapServices.get<double>({}, ['height'], defaultValue: 0.0);
```

### Methods

```Dart
ThanPkg.appUtil.getParseMinutes(minutes);
ThanPkg.appUtil.copyText(text);
ThanPkg.appUtil.pasteText();
await ThanPkg.appUtil.clearImageCache();
```

### Extensions

```Dart
// extension
DateTime.now().toParseTime();
DateTime.now().toTimeAgo();
//double
0.0.toFileSizeLabel();
//FileSystemEntityExtension
FileSystemEntityExtension.getName(withExt: false)

//PlatformExtension
PlatformExtension.isDesktop();
PlatformExtension.isMobile();

//StringExtension
"".toCaptalize();
"".getName();
"".getExt();
//TextEditingControllerExtension
TextEditingController().selectAll();
```

### Thumbnail for linux,android

```Dart
await ThanPkg.platform.genPdfThumbnail(pathList: [
SrcDestType(src: '$path/Download/1-50.pdf', dist: '$path/test.png'),
]);

await ThanPkg.platform.genVideoThumbnail(pathList: [
SrcDestType(
    src: '$path/Download/catch.mp4', dist: '$path/catch-video.png'),
]);
```

### Launch

- `ThanPkg.android.app.launch`
- `ThanPkg.linux.app.launch`
- `ThanPkg.platform.launch`

- Ubuntu/Debian

```bash
sudo apt install xdg-utils
```

- Arch

```bash
sudo pacman -S xdg-utils
```

- Fedora

```bash
sudo dnf install xdg-utils
```

### Android ScreenOrientation

```Dart
final type = await ThanPkg.android.app.getOrientation();
if (type == null) return;
if (type == ScreenOrientationTypes.Portrait) {
await ThanPkg.android.app
    .requestOrientation(type: ScreenOrientationTypes.Landscape);
await ThanPkg.android.app.showFullScreen();
} else {
ThanPkg.android.app
    .requestOrientation(type: ScreenOrientationTypes.Portrait);
await ThanPkg.android.app.hideFullScreen();
}
```

### Android Manifest

```xml
<application>
<provider
    android:name="than.plugin.than_pkg.TContentProvider"
    android:authorities="${applicationId}.provider"
    android:exported="false"
    android:grantUriPermissions="true" />

</application>
```

- for above android xml code

```Dart
Future<void> openPdfWithIntent({required String path})
Future<void> openVideoWithIntent({required String path})
Future<void> installApk({required String path})
```

### Android Thumbnail

- ThanPkg.android.thumbnail

```Dart
Future<void> genVideoThumbnailList
Future<String?> genVideoThumbnail
Future<void> genPdfCoverList
Future<String> genPdfImage
Future<int> getPdfPageCount
```

### Android Camera

```Dart
final filePath = await ThanPkg.android.camera.openCamera();
```

### Android Storage Permission (All Version)

```Dart
if (!await ThanPkg.android.permission.isStoragePermissionGranted()) {
    await ThanPkg.android.permission.requestStoragePermission();
    return;
}
if (!await ThanPkg.android.permission.isCameraPermission()) {
    await ThanPkg.android.permission.requestCameraPermission();
    return;
}
```

- ThanPkg.android.permission

```Dart
Future<void> checkCanRequestPackageInstallsPermission
Future<bool> isPackageInstallPermission()
Future<bool> isStoragePermissionGranted()
Future<bool> isCameraPermission()
Future<bool> isLocationPermission()
Future<void> requestStoragePermission()
Future<void> requestPackageInstallPermission()
Future<void> requestCameraPermission()
Future<void> requestLocationPermission()
```

# Android && linux

```Dart
//old method
await ThanPkg.windowManagerensureInitialized();
await ThanPkg.platform.toggleFullScreen(isFullScreen: true);
await ThanPkg.platform.getAppRootPath();
await ThanPkg.platform.getAppExternalPath();
await ThanPkg.platform.getWifiAddressList();
await ThanPkg.platform.genPdfCover(outDirPath: '', pdfPathList: []);
await ThanPkg.platform.genVideoCover(outDirPath: '', videoPathList: []);
```

# Android Permission

```Dart
//android any version can handle
await ThanPkg.platform.isStoragePermissionGranted();
await ThanPkg.platform.requestStoragePermission();
await ThanPkg.platform.checkAndRequestPackageInstallPermission();
```

# Android only

```Dart
//old method
await ThanPkg.platform.getAppFilePath();
await ThanPkg.platform.isAppSystemThemeDarkMode();
await ThanPkg.platform.isAppInternetConnected();
await ThanPkg.platform.getAppBatteryLevel();
await ThanPkg.platform.getLastKnownLocation();
await ThanPkg.platform.getInstalledApps();
await ThanPkg.platform.checkScreenOrientation();
await ThanPkg.platform.requestScreenOrientation(type: ScreenOrientationTypes.Portrait);
//android device info <Map> type
await ThanPkg.platform.getAndroidDeviceInfo()
await ThanPkg.platform.openUrl(url: '');
await ThanPkg.platform.getPlatformVersion();
await ThanPkg.platform.getDeviceId();
await ThanPkg.platform.toggleKeepScreen(isKeep: false);
await ThanPkg.platform.toggleFullScreen(isFullScreen: !isFullScreen);
await ThanPkg.platform.getLocalIpAddress();
await ThanPkg.platform.getWifiAddress();
```

# android AndroidManifest

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />

```
