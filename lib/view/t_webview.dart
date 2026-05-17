import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class TWebview extends StatelessWidget {
  final String url;
  const TWebview({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return AndroidView(
      viewType: 't-webview',
      creationParams: {'url': url},
      creationParamsCodec: StandardMessageCodec(),
    );
  }
}
