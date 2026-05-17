import 'package:flutter/services.dart';
import 'package:than_pkg/enums/android_intent_data.dart';

class AndroidIntentUtil {
  static final AndroidIntentUtil instance = AndroidIntentUtil._();
  AndroidIntentUtil._();
  factory AndroidIntentUtil() => instance;

  final _channel = const MethodChannel('than_pkg');
  final _name = 'intentUtil';

  ///
  ///`usage` call -> `AndroidSettings.ACTION_SETTINGS`
  ///
  ///
  Future<void> callSettingIntent({required String actionType}) async {
    await _channel.invokeMethod('$_name/callSettingIntent', {
      'actionType': actionType,
    });
  }

  ///
  ///`usage` call -> `AndroidIntents.ACTION_DIAL`
  ///```Dart
  /// //Call Phone Dialer
  ///await ThanPkg.android.intent.callIntent(
  ///   intentType: AndroidIntents.ACTION_DIAL,
  ///   uri: Uri.parse('tel:[number]'),
  /// );
  ///
  /// //Call Other App
  /// await ThanPkg.android.intent.callIntent(
  ///   intentType: AndroidIntents.ACTION_VIEW,
  ///   uri: Uri.parse('https://github.com/'),
  /// );
  /// // Share
  /// await ThanPkg.android.intent.callIntent(
  ///   intentType: AndroidIntentData.ACTION_SEND,
  ///   extras: {
  ///     AndroidIntentData.EXTRA_TEXT: "Hello World",
  ///     AndroidIntentData.EXTRA_SUBJECT: "Subject Example",
  ///   },
  ///   mimeType: "text/plain", // important
  /// );
  ///```
  Future<void> callIntent({
    required String intentType,
    Uri? uri,
    Map<String, dynamic>? extras = const {},
    String? mimeType,
  }) async {
    Map<String, dynamic> map = {'intentType': intentType};
    if (uri != null) {
      map['uriString'] = uri.toString();
    }
    if (extras != null) {
      map['extras'] = extras;
    }
    if (mimeType != null) {
      map['mime'] = mimeType;
    }
    await _channel.invokeMethod('$_name/callIntent', map);
  }

  ///
  /// it will opened android share dialog.
  ///
  ///```Dart
  /// await callIntent(
  ///     intentType: AndroidIntentData.ACTION_SEND,
  ///     extras: {AndroidIntentData.EXTRA_TEXT: url},
  ///     mimeType: mimeType ?? "text/plain", // important
  /// );
  /// ```
  Future<void> shareUrl({required String url, String? mimeType}) async {
    await callIntent(
      intentType: AndroidIntentData.ACTION_SEND,
      extras: {AndroidIntentData.EXTRA_TEXT: url},
      mimeType: mimeType ?? "text/plain", // important
    );
  }
}
