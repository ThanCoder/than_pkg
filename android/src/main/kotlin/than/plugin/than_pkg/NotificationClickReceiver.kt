package than.plugin.than_pkg

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class NotificationClickReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        val id = intent?.getIntExtra("notification_id", -1) ?: -1
        print("click noti")
        // Flutter ကို ပို့
        ThanPkgPlugin.methodChannel?.invokeMethod(
            "notificationClick",
            id
        )
    }
}