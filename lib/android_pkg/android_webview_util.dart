import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:than_pkg/interfaces/webview_interface.dart';

class AndroidWebviewUtil implements WebviewInterface {
  static final AndroidWebviewUtil instance = AndroidWebviewUtil._();
  AndroidWebviewUtil._();
  factory AndroidWebviewUtil() => instance;

  final _channel = const MethodChannel('than_pkg');
  final _name = 'webviewUtil';

  @override
  Future<Map<String, dynamic>> onClickElementListener() async {
    final completer = Completer<Map<String, dynamic>>();
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'webview-onClick') {
        final json = call.arguments ?? {};
        // print('Clicked element: $elementId');
        completer.complete(jsonDecode(json));
      }
    });
    return completer.future;
  }

  @override
  Future<String> onPageFinished() async {
    final completer = Completer<String>();
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'webview-onHtml') {
        final html = call.arguments ?? '';
        completer.complete(html);
      }
    });
    return completer.future;
  }

  @override
  Future<String?> getHtml() async {
    final res = await _channel.invokeMethod<String>('$_name/getHtml');
    return res;
  }

  @override
  Future<bool> canGoBack() async {
    return await _channel.invokeMethod<bool>('$_name/canGoBack') ?? false;
  }

  @override
  Future<bool> canGoBackOrForward({required int step}) async {
    return await _channel.invokeMethod<bool>('$_name/canGoBackOrForward') ??
        false;
  }

  @override
  Future<bool> canGoForward() async {
    return await _channel.invokeMethod<bool>('$_name/canGoForward') ?? false;
  }

  @override
  Future<void> clearCache({required bool includeDiskFiles}) async {
    await _channel.invokeMethod<bool>('$_name/clearCache', {
      'includeDiskFiles': includeDiskFiles,
    });
  }

  @override
  Future<void> clearHistory() async {
    await _channel.invokeMethod<bool>('$_name/clearHistory');
  }

  @override
  Future<String?> evaluateJavascript({
    required String script,
    bool isEscapeForJsonJs = false,
  }) async {
    return await _channel.invokeMethod<String>('$_name/evaluateJavascript', {
      'script': script,
      'isEscapeForJsonJs': isEscapeForJsonJs,
    });
  }

  @override
  Future<void> goBack() async {
    await _channel.invokeMethod<void>('$_name/goBack');
  }

  @override
  Future<void> goForward() async {
    await _channel.invokeMethod<void>('$_name/goForward');
  }

  @override
  Future<void> keepScreenOn() async {
    await _channel.invokeMethod<void>('$_name/keepScreenOn');
  }

  @override
  Future<void> loadUrl({required String url}) async {
    await _channel.invokeMethod<void>('$_name/loadUrl', {'url': url});
  }

  @override
  Future<String?> originalUrl() async {
    return await _channel.invokeMethod<String>('$_name/originalUrl');
  }

  @override
  Future<int?> progress() async {
    return await _channel.invokeMethod<int>('$_name/progress');
  }

  @override
  Future<void> reload() async {
    await _channel.invokeMethod('$_name/reload');
  }

  @override
  Future<String?> title() async {
    return await _channel.invokeMethod<String>('$_name/title');
  }

  @override
  Future<String?> url() async {
    return await _channel.invokeMethod<String>('$_name/url');
  }

  @override
  Future<void> zoomIn() async {
    await _channel.invokeMethod('$_name/zoomIn');
  }

  @override
  Future<void> zoomOut() async {
    await _channel.invokeMethod('$_name/zoomOut');
  }
}
