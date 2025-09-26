package than.plugin.than_pkg

import android.app.Activity
import android.content.Context
import android.content.Intent
import androidx.core.net.toUri
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

object IntentUtil {

    fun callCheck(
        call: MethodCall,
        result: MethodChannel.Result,
        context: Context,
        activity: Activity
    ) {
        val method = call.method.replace("intentUtil/", "")
        when (method) {
            "callSettingIntent" -> {
                try {
                    val actionType = call.argument<String>("actionType") ?: ""
                    val intent = Intent(actionType)
                    activity.startActivity(intent)
                    result.success(true)
                } catch (e: Exception) {
                    result.error("ERROR", e.toString(), null)
                }
            }

            "callIntent" -> {
                try {
                    val intentType = call.argument<String>("intentType") ?: ""
                    val extras = call.argument<Map<String, Any>>("extras")
                    val uriString = call.argument<String>("uriString")
                    val mime = call.argument<String>("mime")
                    val intent = Intent(intentType)
                    if (uriString != null) {
                        intent.setData(uriString.toUri())
                    }
                    if (mime != null) {
                        intent.setType(mime)
                    }

                    extras?.forEach { (key, value) ->
                        when (value) {
                            is String -> intent.putExtra(key, value)
                            is Int -> intent.putExtra(key, value)
                            is Boolean -> intent.putExtra(key, value)
                            is Float -> intent.putExtra(key, value)
                            is Double -> intent.putExtra(key, value)
                            // လိုအပ်ရင် အခြား type တွေထည့်နိုင်
                        }
                    }

                    activity.startActivity(intent)
                    result.success(true)
                } catch (e: Exception) {
                    result.error("ERROR", e.toString(), null)
                }
            }
        }
    }

}