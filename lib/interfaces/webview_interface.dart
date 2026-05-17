abstract class WebviewInterface {
  Future<Map<String, dynamic>> onClickElementListener();
  Future<String> onPageFinished();
  Future<String?> getHtml();
  Future<String?> evaluateJavascript({
    required String script,
    bool isEscapeForJsonJs = false,
  });
  Future<bool> canGoBack();
  Future<void> goBack();
  Future<bool> canGoForward();
  Future<void> goForward();
  Future<bool> canGoBackOrForward({required int step});
  Future<void> reload();
  Future<void> loadUrl({required String url});
  Future<void> clearCache({required bool includeDiskFiles});
  Future<void> clearHistory();
  Future<String?> url();
  Future<String?> originalUrl();
  Future<String?> title();
  Future<int?> progress();
  Future<void> keepScreenOn();
  Future<void> zoomIn();
  Future<void> zoomOut();
}
