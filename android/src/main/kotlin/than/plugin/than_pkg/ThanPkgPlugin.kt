package than.plugin.than_pkg

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.graphics.Bitmap
import android.net.Uri
import android.webkit.WebView
import com.example.myapplication.NotiUtil
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import io.flutter.view.TextureRegistry

/** ThanPkgPlugin */
class ThanPkgPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    PluginRegistry.RequestPermissionsResultListener {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private var activity: Activity? = null
    private var webView: WebView? = null

    private lateinit var textureRegistry: TextureRegistry;

    companion object {
        var methodChannel: MethodChannel? = null

    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "than_pkg")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
        textureRegistry = flutterPluginBinding.textureRegistry
        methodChannel = channel

        //web view
        flutterPluginBinding.platformViewRegistry.registerViewFactory(
            "t-webview",
            WebviewFactory(context, channel, webViewCallback = { view ->
                webView = view
            })
        )

        // EventChannel set
        val eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "mediaUtil/progress")
        MediaUtil.setEventChannel(eventChannel)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        //listen activity result
        binding.addRequestPermissionsResultListener(this)
        binding.addActivityResultListener { reqCode, resultCode, data ->
            if (resultCode == Activity.RESULT_OK) {
                //camera
                if (reqCode == 20000) {
                    val imageUri: Uri? = data?.data
                    val imageBitmap = data?.extras?.get("data") as? Bitmap
                    if (imageUri == null) {
                        imageBitmap?.let {
                            //save bitmap
                            val filePath = FileUtil.saveBitmapToFile(context, it)
                            channel.invokeMethod(
                                "onCameraResult", mapOf(
                                    "requestCode" to reqCode,
                                    "resultCode" to resultCode,
                                    "data" to filePath,
                                )
                            )
                        }
                    } else {
                        channel.invokeMethod(
                            "onCameraResult", mapOf(
                                "requestCode" to reqCode,
                                "resultCode" to resultCode,
                                "data" to imageUri.toString(),
                            )
                        )
                    }


                } else {
                    channel.invokeMethod(
                        "onActivityResult", mapOf(
                            "requestCode" to reqCode,
                            "resultCode" to resultCode,
                            "data" to data?.toString(),
                        )
                    )
                }
            }
            true
        }

    }


    @SuppressLint("HardwareIds", "NewApi", "SourceLockedOrientationActivity", "MissingPermission")
    override fun onMethodCall(call: MethodCall, result: Result) {
        when {
            call.method.startsWith("appUtil/") -> {
                AppUtil.callCheck(call, result, context, activity)
            }

            call.method.startsWith("cameraUtil/") -> {
                CameraUtil.callCheck(call, result, context, activity)
            }

            call.method.startsWith("locationUtil/") -> {
            }

            call.method.startsWith("pdfUtil/") -> {
                PdfUtil.callCheck(call, result, context, activity)
            }

            call.method.startsWith("videoUtil/") -> {
                VideoUtil.callCheck(call, result, context, activity)
            }

            call.method.startsWith("permissionUtil/") -> {
                PermissionUtil.callCheck(call, result, context, activity)
            }

            call.method.startsWith("wifiUtil/") -> {
                WifiUtil.callCheck(call, result, context, activity)
            }

            call.method.startsWith("notiUtil/") -> {
                NotiUtil.callCheck(call, result, context, activity)
            }

            call.method.startsWith("webviewUtil/") -> {
                webView?.let {
                    it
                    WebviewUtil.callCheck(call, result, it)
                }
            }

            call.method.startsWith("mediaUtil/") -> {
                MediaUtil.callCheck(call, result, textureRegistry)
            }

            call.method.startsWith("intentUtil/") -> {
                activity?.let { it -> IntentUtil.callCheck(call, result, context, it) }
            }

            else -> {
                result.notImplemented()
            }
        }


    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        TODO("Not yet implemented")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        TODO("Not yet implemented")
    }

    override fun onDetachedFromActivity() {
        TODO("Not yet implemented")
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String?>,
        grantResults: IntArray
    ): Boolean {
        print("called: onRequestPermissionsResult")
        NotiUtil.handlePermissionResult(
            requestCode,
            permissions,
            grantResults,
            onResult = { isGranted ->
                print("notiPermissionResult: $isGranted")
                channel.invokeMethod("notiPermissionResult", isGranted)
            })
        return true
    }


}
