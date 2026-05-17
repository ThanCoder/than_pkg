package than.plugin.than_pkg

import android.content.Context
import android.content.pm.PackageInfo
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.util.Base64
import java.io.ByteArrayOutputStream
import java.util.concurrent.Executors
import androidx.core.graphics.createBitmap

object ApkUtil {

    private val handler = Handler(Looper.getMainLooper())
    private val executorService = Executors.newSingleThreadExecutor()
    @Suppress("DEPRECATION")
    fun getInstalledApps(context: Context,
                         onLoaded:(list:List<Map<String, Any?>>) -> Unit,
                         onError:(msg:String) -> Unit
    ) {
        executorService.execute {
            try {
                val pm = context.packageManager
                val packages: List<PackageInfo> = pm.getInstalledPackages(0)
//			val packages = pm.getInstalledPackages(PackageManager.GET_META_DATA)

                val apps = mutableListOf<Map<String, Any?>>()

                for (pkg in packages) {
                    val appName = pkg.applicationInfo?.let { pm.getApplicationLabel(it) }.toString()
                    val packageName = pkg.packageName
                    val versionName = pkg.versionName ?: "N/A"
                    val versionCode =
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) pkg.longVersionCode.toString()
                        else pkg.versionCode.toString()
                    val size = getApkSize(context,packageName)
                    val iconBase64 = getAppIconBase64(context,packageName)
                    apps.add(
                        mapOf(
                            "appName" to appName,
                            "packageName" to packageName,
                            "versionName" to versionName,
                            "versionCode" to versionCode,
                            "size" to size,
                            "iconBase64" to iconBase64
                            )
                    )
                }
                handler.post { onLoaded(apps) }
            }catch (e:Exception) {
                handler.post { onError(e.toString()) }
            }

        }

    }


    fun exportApk(context: Context,packageName: String,savedPath:String): String? {
        return try {
            val pm = context.packageManager
            val appInfo = pm.getApplicationInfo(packageName, 0)
            val apkPath = appInfo.sourceDir

            val srcFile = java.io.File(apkPath)
//			val destDir = context.getExternalFilesDir(null)
//			val destFile = java.io.File(destDir, "$packageName.apk")
            val destFile = java.io.File(savedPath)

            srcFile.copyTo(destFile, overwrite = true)

            destFile.absolutePath
        } catch (e: Exception) {
            e.printStackTrace()
            null
        }
    }
    fun getApkSize(context: Context,packageName: String): Long? {
        return try {
            val pm = context.packageManager
            val appInfo = pm.getApplicationInfo(packageName, 0)
            val apkPath = appInfo.sourceDir

            val srcFile = java.io.File(apkPath)

            srcFile.length()
        } catch (e: Exception) {
            e.printStackTrace()
            null
        }
    }

    fun getAppIconBase64(context: Context, packageName: String): String? {
        return try {
            val pm = context.packageManager
            val appInfo = pm.getApplicationInfo(packageName, 0)

            val drawable = pm.getApplicationIcon(appInfo)

            // Drawable → Bitmap convert
            val bitmap = if (drawable is BitmapDrawable) {
                drawable.bitmap
            } else {
                val width = if (drawable.intrinsicWidth > 0) drawable.intrinsicWidth else 96
                val height = if (drawable.intrinsicHeight > 0) drawable.intrinsicHeight else 96
                val bmp = createBitmap(width, height)
                val canvas = Canvas(bmp)
                drawable.setBounds(0, 0, canvas.width, canvas.height)
                drawable.draw(canvas)
                bmp
            }

            val outputStream = ByteArrayOutputStream()
            bitmap.compress(Bitmap.CompressFormat.PNG, 100, outputStream)
            val byteArray = outputStream.toByteArray()

            Base64.encodeToString(byteArray, Base64.NO_WRAP)

        } catch (e: Exception) {
            e.printStackTrace()
            null
        }
    }



}