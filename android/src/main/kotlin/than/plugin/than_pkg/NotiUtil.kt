package com.example.myapplication

import android.Manifest
import android.R
import android.annotation.SuppressLint
import android.app.Activity
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.provider.Settings
import androidx.annotation.RequiresApi
import androidx.annotation.RequiresPermission
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.ContextCompat
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import than.plugin.than_pkg.NotificationClickReceiver

//<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
object NotiUtil {

    @RequiresPermission(Manifest.permission.POST_NOTIFICATIONS)
    @RequiresApi(Build.VERSION_CODES.TIRAMISU)
    fun callCheck(
        call: MethodCall,
        result: MethodChannel.Result,
        context: Context,
        activity: Activity?
    ) {
        val method = call.method.replace("notiUtil/", "")
        when (method) {
            "askNotificationPermission" -> {
                activity?.let {
                    try {
                        val reqCode = call.argument<Int>("requestCode") ?: 1001
                        askNotificationPermission(activity, reqCode, onGranted = {
                            result.success(true)
                        })
                    } catch (err: Exception) {
                        result.error("ERROR", err.toString(), err)
                    }
                }
            }

            "showNotification" -> {
                try {

                    showNotification(
                        context, call
                    )
                    result.success(true)
                } catch (err: Exception) {
                    result.error("ERROR", err.toString(), err)
                }
            }

            "showProgressNotification" -> {
                try {
                    val notificationManager = NotificationManagerCompat.from(context)
                    showProgressNotification(context, call, notificationManager)
                    result.success(true)
                } catch (err: Exception) {
                    result.error("ERROR", err.toString(), err)
                }

            }

            "showCompleteNotification" -> {
                try {
                    val notificationManager = NotificationManagerCompat.from(context)
                    showCompleteNotification(context, call, notificationManager)
                    result.success(true)
                } catch (err: Exception) {
                    result.error("ERROR", err.toString(), err)
                }

            }
        }
    }

    private fun getPendingIntent(context: Context, notificationId: Int): PendingIntent {
        val intent = Intent(context, NotificationClickReceiver::class.java).apply {
            action = "MEDIA_NOTIFICATION_CLICK"
            putExtra("notification_id", notificationId) // id ပေး
        }

        return PendingIntent.getBroadcast(
            context,
            notificationId, // requestCode, unique ဖြစ်အောင်
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
    }

    private var REQUEST_CODE = 1001

    @RequiresApi(Build.VERSION_CODES.TIRAMISU)
    fun askNotificationPermission(
        activity: Activity,
        reqCode: Int = 1001,
        onGranted: () -> Unit
    ) {
        val permission = Manifest.permission.POST_NOTIFICATIONS

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            when {
                // Permission already granted
                ContextCompat.checkSelfPermission(
                    activity,
                    permission
                ) == PackageManager.PERMISSION_GRANTED -> {
                    onGranted()
                }

                // User denied before but not "Don't ask again"
                ActivityCompat.shouldShowRequestPermissionRationale(activity, permission) -> {
                    // Explain why you need permission (optional)
                    ActivityCompat.requestPermissions(activity, arrayOf(permission), reqCode)
                }

                // First time request OR "Don't ask again" selected
                else -> {
                    // Try requesting permission first
                    ActivityCompat.requestPermissions(activity, arrayOf(permission), reqCode)

                    // Schedule a delayed check to see if permission was denied with "Don't ask again"
                    Handler(Looper.getMainLooper()).postDelayed({
                        if (ContextCompat.checkSelfPermission(
                                activity,
                                permission
                            ) != PackageManager.PERMISSION_GRANTED
                            && !ActivityCompat.shouldShowRequestPermissionRationale(
                                activity,
                                permission
                            )
                        ) {
                            // Redirect to app notification settings
                            val intent = Intent(Settings.ACTION_APP_NOTIFICATION_SETTINGS).apply {
                                putExtra(Settings.EXTRA_APP_PACKAGE, activity.packageName)
                            }
                            activity.startActivity(intent)
                        }
                    }, 500) // 0.5 sec delay to allow system popup
                }
            }
        } else {
            // < Android 13, permission not needed
            onGranted()
            println("✅ Notification permission not needed (< Android 13)")
        }
    }


    // ဒီ callback ကို Activity မှာ အလိုအလျောက် ပြန်ခေါ်မယ်
    fun handlePermissionResult(
        requestCode: Int,
        permissions: Array<out String?>,
        grantResults: IntArray,
        onResult: (Boolean) -> Unit
    ) {
        if (requestCode == REQUEST_CODE) {
            if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                onResult(true)
            } else {
                onResult(false)
            }
        }
    }


    @SuppressLint("MissingPermission", "LaunchActivityFromNotification")
    fun showNotification(
        context: Context,
        call: MethodCall
    ) {

        val notificationId = call.argument<Int>("notificationId") ?: 1
        val channelId = call.argument<String>("channelId") ?: "c_id"
        val channelName = call.argument<String>("channelName") ?: "c_name"
        val channelDesc = call.argument<String>("channelDesc") ?: "Channel description"
        val title = call.argument<String>("title") ?: "Title"
        val content = call.argument<String>("content") ?: "Content"

        // ✅ Android 8.0+ မှာ NotificationChannel register လုပ်ရမယ်
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val channel = NotificationChannel(channelId, channelName, importance).apply {
                description = channelDesc
            }

            val notificationManager: NotificationManager =
                context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }

        val intent = Intent(context, NotificationClickReceiver::class.java).apply {
            putExtra("notification_id", notificationId)
        }

        val pendingIntent = PendingIntent.getBroadcast(
            context,
            notificationId,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )


        // ✅ Notification Builder
        val builder = NotificationCompat.Builder(context, channelId)
            .setSmallIcon(android.R.drawable.ic_dialog_info) // icon တစ်ခုလိုအပ်တယ်
            .setContentTitle(title)
            .setContentText(content)
            .setContentIntent(pendingIntent)
            .setAutoCancel(true)
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)

        // ✅ Notification Manager ကနေ show
        with(NotificationManagerCompat.from(context)) {
            notify(notificationId, builder.build()) // notification ID = 1
        }
    }

    //    progress


    @RequiresPermission(Manifest.permission.POST_NOTIFICATIONS)
    fun showProgressNotification(
        context: Context, call: MethodCall, manager: NotificationManagerCompat
    ) {
        val notificationId = call.argument<Int>("notificationId") ?: 1
        val channelId = call.argument<String>("channelId") ?: "c_id"
        val channelName = call.argument<String>("channelName") ?: "c_name"
        val channelDesc = call.argument<String>("channelDesc") ?: "Channel description"
        val title = call.argument<String>("title") ?: "Title"
        val content = call.argument<String>("content") ?: "Content"
        val progress = call.argument<Int>("progress") ?: 0
        val indeterminate = call.argument<Boolean>("indeterminate") ?: false

        // Channel (Android 8+)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                channelId,
                channelName,
                NotificationManager.IMPORTANCE_LOW
            ).apply { description = channelDesc }
            manager.createNotificationChannel(channel)
        }

        val builder = NotificationCompat.Builder(context, channelId)
            .setSmallIcon(R.drawable.stat_sys_download)
            .setContentTitle(title)
            .setContentText(content)
            .setOnlyAlertOnce(true)
            .setProgress(100, progress, indeterminate)

        manager.notify(notificationId, builder.build())
    }

    @RequiresPermission(Manifest.permission.POST_NOTIFICATIONS)
    fun showCompleteNotification(
        context: Context,
        call: MethodCall,
        manager: NotificationManagerCompat
    ) {
        val notificationId = call.argument<Int>("notificationId") ?: 1
        val channelId = call.argument<String>("channelId") ?: "c_id"
        val title = call.argument<String>("title") ?: "Completed"
        val content = call.argument<String>("content") ?: "Done"

        val builder = NotificationCompat.Builder(context, channelId)
            .setSmallIcon(R.drawable.stat_sys_download_done)
            .setContentTitle(title)
            .setContentText(content)
            .setContentIntent(getPendingIntent(context, notificationId))
            .setAutoCancel(true)
            .setProgress(0, 0, false)

        manager.notify(notificationId, builder.build())

    }


    // requestPermissions() က ပြန်ခေါ်မယ့် callback
    // override fun onRequestPermissionsResult(
    //     requestCode: Int,
    //     permissions: Array<out String>,
    //     grantResults: IntArray
    // ) {
    //     super.onRequestPermissionsResult(requestCode, permissions, grantResults)
    //     NotiUtil.handlePermissionResult(
    //         requestCode,
    //         permissions,
    //         grantResults,
    //         onResult = { isGranted ->
    //             showNotification()
    //         })
    // }
}