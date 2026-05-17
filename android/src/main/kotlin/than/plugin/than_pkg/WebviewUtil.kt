package than.plugin.than_pkg

import android.webkit.WebView
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

object WebviewUtil {

    fun callCheck(
        call: MethodCall,
        result: MethodChannel.Result,
        webView: WebView,
    ) {
        val method = call.method.replace("webviewUtil/", "")

        when (method) {
            "getHtml" -> {
                webView.evaluateJavascript(
                    "(function() { return document.documentElement.outerHTML; })();"
                ) { html ->
                    result.success(escapeForJsonJs(html))
                }
            }

            "evaluateJavascript" -> {
                val script = call.argument<String>("script") ?: ""
                val isEscapeForJsonJs = call.argument<Boolean>("isEscapeForJsonJs") ?: false
                if (script.isEmpty()) {
                    result.error("SCRIPT_ERROR", "script is empty", null)
                    return
                }

                try {
                    webView.evaluateJavascript(script) { value ->
                        if (isEscapeForJsonJs) {
                            result.success(escapeForJsonJs(value)) // JS return value
                        } else {
                            result.success(value) // JS return value
                        }
                        
                    }
                } catch (e: Exception) {
                    result.error("JS_ERROR", e.message, null)
                }
            }

            "canGoBack" -> {
                result.success(webView.canGoBack())
            }

            "goBack" -> {
                webView.goBack()
                result.success(true)
            }

            "canGoForward" -> {
                result.success(webView.canGoForward())
            }

            "goForward" -> {
                webView.goForward()
                result.success(true)
            }

            "canGoBackOrForward" -> {
                val step = call.argument<Int>("step") ?: 0
                result.success(webView.canGoBackOrForward(step))
            }

            "reload" -> {
                webView.reload()
                result.success(true)
            }

            "loadUrl" -> {
                val url = call.argument<String>("url") ?: ""
                webView.loadUrl(url)
                result.success(true)
            }

            "clearCache" -> {
                val includeDiskFiles = call.argument<Boolean>("includeDiskFiles") ?: false
                webView.clearCache(includeDiskFiles)
                result.success(true)
            }

            "clearHistory" -> {
                webView.clearHistory()
                result.success(true)
            }

            "url" -> {
                result.success(webView.url)
            }

            "originalUrl" -> {
                result.success(webView.originalUrl)
            }

            "title" -> {
                result.success(webView.title)
            }

            "progress" -> {
                result.success(webView.progress)
            }

            "keepScreenOn" -> {
                result.success(webView.keepScreenOn)
            }

            "zoomIn" -> {
                webView.zoomIn()
                result.success(true)
            }

            "zoomOut" -> {
                webView.zoomOut()
                result.success(true)
            }

            else -> result.notImplemented()
        }
    }

    fun escapeForJsonJs(input: String): String {
        // Unicode \uXXXX decode
        val unicodeRegex = Regex("""\\u([0-9A-Fa-f]{4})""")
        var decoded = unicodeRegex.replace(input) {
            val code = it.groupValues[1].toInt(16)
            code.toChar().toString()
        }

        // JSON style escaped characters ပြန်ပြောင်း
        decoded = decoded.replace("\\\"", "\"")
            .replace("\\n", "\n")
            .replace("\\t", "\t")
            .replace("\\'", "'")

        // JS string return က "" သို့မဟုတ် quotes wrap လုပ်ထားနိုင်တာ ပြန်ဖြုတ်
        if (decoded.startsWith("\"") && decoded.endsWith("\"")) {
            decoded = decoded.substring(1, decoded.length - 1)
        }

        return decoded
    }
}