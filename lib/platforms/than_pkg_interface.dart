import 'package:package_info_plus/package_info_plus.dart';
import 'package:than_pkg/types/src_dest_type.dart';

abstract class ThanPkgInterface {
  Future<List<String>> getWifiAddressList();
  Future<void> openUrl({required String url});
  Future<void> toggleFullScreen({required bool isFullScreen});
  Future<void> genPdfCover({
    required String outDirPath,
    required List<String> pdfPathList,
    int iconSize = 300,
  });

  Future<void> genVideoCover({
    required String outDirPath,
    required List<String> videoPathList,
    int iconSize = 300,
  });

  Future<bool> isStoragePermissionGranted();
  Future<void> requestStoragePermission();

  Future<String?> getDeviceId();
  Future<String?> getPlatformVersion();
  Future<String?> getLocalIpAddress();
  Future<void> toggleKeepScreen({required bool isKeep});
  Future<String?> getAppRootPath();
  Future<String?> getAppExternalPath();

  Future<bool> isAppSystemThemeDarkMode();
  Future<int?> getAppBatteryLevel();
  Future<String?> getWifiSSID();

  Future<PackageInfo> getPackageInfo();
  Future<void> launch(String source);

  //new methods
  Future<void> genPdfThumbnail({
    required List<SrcDestType> pathList,
    int iconSize = 300,
    bool isOverride = false,
  });

  Future<void> genVideoThumbnail({
    required List<SrcDestType> pathList,
    int iconSize = 300,
    bool isOverride = false,
  });

  Future<bool> isInternetConnected();
  // notification
  Future<void> showNotification({
    required String title,
    int? notificationId,
    String content = 'content',
  });

  Future<List<String>> getABI();
}
