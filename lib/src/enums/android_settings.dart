// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class AndroidSettings {
  ///
  /// Main settings
  ///
  static final String ACTION_SETTINGS = "android.settings.SETTINGS";

  ///
  /// Wireless & Networks
  ///
  static final String ACTION_WIRELESS_SETTINGS =
      "android.settings.WIRELESS_SETTINGS";
  static final String ACTION_AIRPLANE_MODE_SETTINGS =
      "android.settings.AIRPLANE_MODE_SETTINGS";
  static final String ACTION_WIFI_SETTINGS = "android.settings.WIFI_SETTINGS";
  static final String ACTION_BLUETOOTH_SETTINGS =
      "android.settings.BLUETOOTH_SETTINGS";
  static final String ACTION_DATA_ROAMING_SETTINGS =
      "android.settings.DATA_ROAMING_SETTINGS";
  static final String ACTION_APN_SETTINGS = "android.settings.APN_SETTINGS";
  static final String ACTION_VPN_SETTINGS = "android.settings.VPN_SETTINGS";

  // Location
  static final String ACTION_LOCATION_SOURCE_SETTINGS =
      "android.settings.LOCATION_SOURCE_SETTINGS";

  // Security / Privacy
  static final String ACTION_SECURITY_SETTINGS =
      "android.settings.SECURITY_SETTINGS";
  static final String ACTION_PRIVACY_SETTINGS =
      "android.settings.PRIVACY_SETTINGS";
  static final String ACTION_BIOMETRIC_ENROLL =
      "android.settings.BIOMETRIC_ENROLL";

  // Accessibility
  static final String ACTION_ACCESSIBILITY_SETTINGS =
      "android.settings.ACCESSIBILITY_SETTINGS";

  // Apps
  static final String ACTION_APPLICATION_SETTINGS =
      "android.settings.APPLICATION_SETTINGS";
  static final String ACTION_MANAGE_ALL_APPLICATIONS_SETTINGS =
      "android.settings.MANAGE_ALL_APPLICATIONS_SETTINGS";
  static final String ACTION_MANAGE_APPLICATIONS_SETTINGS =
      "android.settings.MANAGE_APPLICATIONS_SETTINGS";

  // Users
  static final String ACTION_USER_SETTINGS = "android.settings.USER_SETTINGS";

  // Date & Time
  static final String ACTION_DATE_SETTINGS = "android.settings.DATE_SETTINGS";

  // Display
  static final String ACTION_DISPLAY_SETTINGS =
      "android.settings.DISPLAY_SETTINGS";

  // Input methods
  static final String ACTION_INPUT_METHOD_SETTINGS =
      "android.settings.INPUT_METHOD_SETTINGS";
  static final String ACTION_INPUT_METHOD_SUBTYPE_SETTINGS =
      "android.settings.INPUT_METHOD_SUBTYPE_SETTINGS";

  // Development
  static final String ACTION_DEVICE_INFO_SETTINGS =
      "android.settings.DEVICE_INFO_SETTINGS";
  static final String ACTION_APPLICATION_DEVELOPMENT_SETTINGS =
      "android.settings.APPLICATION_DEVELOPMENT_SETTINGS";

  // System Navigation (may not be available on all devices, hidden API sometimes)
  static final String ACTION_SYSTEM_NAVIGATION_SETTINGS =
      "android.settings.SYSTEM_NAVIGATION_SETTINGS";

  // Battery & Power
  static final String ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS =
      "android.settings.IGNORE_BATTERY_OPTIMIZATION_SETTINGS";
  static final String ACTION_BATTERY_SAVER_SETTINGS =
      "android.settings.BATTERY_SAVER_SETTINGS";
  static final String ACTION_BATTERY_USAGE_SUMMARY =
      "android.settings.BATTERY_USAGE_SUMMARY";

  // Storage
  static final String ACTION_INTERNAL_STORAGE_SETTINGS =
      "android.settings.INTERNAL_STORAGE_SETTINGS";

  // Notifications
  static final String ACTION_NOTIFICATION_LISTENER_SETTINGS =
      "android.settings.NOTIFICATION_LISTENER_SETTINGS";
  static final String ACTION_APP_NOTIFICATION_SETTINGS =
      "android.settings.APP_NOTIFICATION_SETTINGS";
  static final String ACTION_CHANNEL_NOTIFICATION_SETTINGS =
      "android.settings.CHANNEL_NOTIFICATION_SETTINGS";

  // Overlay / Special access
  static final String ACTION_MANAGE_OVERLAY_PERMISSION =
      "android.settings.action.MANAGE_OVERLAY_PERMISSION";
  static final String ACTION_MANAGE_UNKNOWN_APP_SOURCES =
      "android.settings.MANAGE_UNKNOWN_APP_SOURCES";
  static final String ACTION_MANAGE_DEFAULT_APPS_SETTINGS =
      "android.settings.MANAGE_DEFAULT_APPS_SETTINGS";

  // WebView
  static final String ACTION_WEBVIEW_SETTINGS =
      "android.settings.WEBVIEW_SETTINGS";

  // Wallet
  static final String ACTION_QUICK_ACCESS_WALLET_SETTINGS =
      "android.settings.QUICK_ACCESS_WALLET_SETTINGS";

  // Tether
  static final String ACTION_TETHER_SETTINGS =
      "android.settings.TETHER_SETTINGS";

  // Regulatory
  static final String ACTION_SHOW_REGULATORY_INFO =
      "android.settings.SHOW_REGULATORY_INFO";
}
