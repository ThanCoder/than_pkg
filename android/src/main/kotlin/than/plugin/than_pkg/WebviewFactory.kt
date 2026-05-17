package than.plugin.than_pkg

import android.annotation.SuppressLint
import android.content.Context
import android.webkit.JavascriptInterface
import android.webkit.WebView
import android.webkit.WebViewClient
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class WebviewFactory(
    private val context: Context,
    private val channel: MethodChannel,
    private val webViewCallback: (WebView) -> Unit
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    @SuppressLint("SetJavaScriptEnabled")
    override fun create(
        context: Context,
        viewId: Int,
        args: Any?
    ): PlatformView {
        val webView = WebView(context)
        val webInterface = WebAppInterface(channel)
        webView.addJavascriptInterface(webInterface, "AndroidBridge")
        webView.settings.javaScriptEnabled = true


        val url = (args as? Map<*, *>)?.get("url") as? String ?: "https://flutter.dev"
        webView.loadUrl(url)

        // plugin class level holder update
        webViewCallback(webView)

        webView.webViewClient = object : WebViewClient() {
            override fun onPageFinished(view: WebView?, url: String?) {
                view?.evaluateJavascript(
                    """
            (function() {
                // 1️⃣ HTML fetch
                var html = document.documentElement.outerHTML;
                html;

            })();
            """
                ) { html ->
                    // Flutter side send HTML content
                    channel.invokeMethod("webview-htmlContent", html)
                }

                val jsCombined = """
                        javascript:(function() {
                            AndroidBridge.onHtml(document.documentElement.outerHTML);
                        
                            document.querySelectorAll('*').forEach(function(el) {
                                el.addEventListener('click', function(e) {
                                    e.stopPropagation();
                                    var data = { id: el.id || "", html: el.outerHTML };
                                    AndroidBridge.onClick(JSON.stringify(data));
                                });
                            });
                        })();
                        """
                view?.evaluateJavascript(jsCombined, null)
            }
        }
        return object : PlatformView {
            override fun getView() = webView

            override fun dispose() {
            }

        }
    }


}


class WebAppInterface(private val channel: MethodChannel) {

    @JavascriptInterface
    fun onClick(data: String) {
        channel.invokeMethod("webview-onClick", data)
    }

    @JavascriptInterface
    fun onHtml(html: String) {
        channel.invokeMethod("webview-onHtml", WebviewUtil.escapeForJsonJs(html))
    }
}

