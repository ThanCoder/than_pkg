// ignore_for_file: constant_identifier_names

class AndroidIntents {
  ///
  /// Standard Activity Actions
  ///
  static const String ACTION_MAIN = "android.intent.action.MAIN";
  static const String ACTION_VIEW = "android.intent.action.VIEW";
  static const String ACTION_ATTACH_DATA = "android.intent.action.ATTACH_DATA";
  static const String ACTION_EDIT = "android.intent.action.EDIT";
  static const String ACTION_PICK = "android.intent.action.PICK";
  static const String ACTION_CHOOSER = "android.intent.action.CHOOSER";
  static const String ACTION_GET_CONTENT = "android.intent.action.GET_CONTENT";
  static const String ACTION_DIAL = "android.intent.action.DIAL";
  static const String ACTION_CALL = "android.intent.action.CALL";
  static const String ACTION_SEND = "android.intent.action.SEND";
  static const String ACTION_SENDTO = "android.intent.action.SENDTO";
  static const String ACTION_ANSWER = "android.intent.action.ANSWER";
  static const String ACTION_INSERT = "android.intent.action.INSERT";
  static const String ACTION_DELETE = "android.intent.action.DELETE";
  static const String ACTION_RUN = "android.intent.action.RUN";
  static const String ACTION_SYNC = "android.intent.action.SYNC";
  static const String ACTION_PICK_ACTIVITY =
      "android.intent.action.PICK_ACTIVITY";
  static const String ACTION_SEARCH = "android.intent.action.SEARCH";
  static const String ACTION_WEB_SEARCH = "android.intent.action.WEB_SEARCH";
  static const String ACTION_FACTORY_TEST =
      "android.intent.action.FACTORY_TEST";

  ///
  /// Standard Broadcast Actions
  ///
  static const String ACTION_TIME_TICK = "android.intent.action.TIME_TICK";
  static const String ACTION_TIME_CHANGED = "android.intent.action.TIME_SET";
  static const String ACTION_TIMEZONE_CHANGED =
      "android.intent.action.TIMEZONE_CHANGED";
  static const String ACTION_BOOT_COMPLETED =
      "android.intent.action.BOOT_COMPLETED";
  static const String ACTION_PACKAGE_ADDED =
      "android.intent.action.PACKAGE_ADDED";
  static const String ACTION_PACKAGE_CHANGED =
      "android.intent.action.PACKAGE_CHANGED";
  static const String ACTION_PACKAGE_REMOVED =
      "android.intent.action.PACKAGE_REMOVED";
  static const String ACTION_PACKAGE_RESTARTED =
      "android.intent.action.PACKAGE_RESTARTED";
  static const String ACTION_PACKAGE_DATA_CLEARED =
      "android.intent.action.PACKAGE_DATA_CLEARED";
  static const String ACTION_PACKAGES_SUSPENDED =
      "android.intent.action.PACKAGES_SUSPENDED";
  static const String ACTION_PACKAGES_UNSUSPENDED =
      "android.intent.action.PACKAGES_UNSUSPENDED";
  static const String ACTION_UID_REMOVED = "android.intent.action.UID_REMOVED";
  static const String ACTION_BATTERY_CHANGED =
      "android.intent.action.BATTERY_CHANGED";
  static const String ACTION_POWER_CONNECTED =
      "android.intent.action.ACTION_POWER_CONNECTED";
  static const String ACTION_POWER_DISCONNECTED =
      "android.intent.action.ACTION_POWER_DISCONNECTED";
  static const String ACTION_SHUTDOWN = "android.intent.action.ACTION_SHUTDOWN";

  ///
  /// Standard Categories
  ///
  static const String CATEGORY_DEFAULT = "android.intent.category.DEFAULT";
  static const String CATEGORY_BROWSABLE = "android.intent.category.BROWSABLE";
  static const String CATEGORY_TAB = "android.intent.category.TAB";
  static const String CATEGORY_ALTERNATIVE =
      "android.intent.category.ALTERNATIVE";
  static const String CATEGORY_SELECTED_ALTERNATIVE =
      "android.intent.category.SELECTED_ALTERNATIVE";
  static const String CATEGORY_LAUNCHER = "android.intent.category.LAUNCHER";
  static const String CATEGORY_INFO = "android.intent.category.INFO";
  static const String CATEGORY_HOME = "android.intent.category.HOME";
  static const String CATEGORY_PREFERENCE =
      "android.intent.category.PREFERENCE";
  static const String CATEGORY_TEST = "android.intent.category.TEST";
  static const String CATEGORY_CAR_DOCK = "android.intent.category.CAR_DOCK";
  static const String CATEGORY_DESK_DOCK = "android.intent.category.DESK_DOCK";
  static const String CATEGORY_LE_DESK_DOCK =
      "android.intent.category.LE_DESK_DOCK";
  static const String CATEGORY_HE_DESK_DOCK =
      "android.intent.category.HE_DESK_DOCK";
  static const String CATEGORY_CAR_MODE = "android.intent.category.CAR_MODE";
  static const String CATEGORY_APP_MARKET =
      "android.intent.category.APP_MARKET";
  static const String CATEGORY_VR_HOME = "android.intent.category.VR_HOME";

  ///
  /// Standard Extra Data
  ///
  static const String EXTRA_ALARM_COUNT = "android.intent.extra.ALARM_COUNT";
  static const String EXTRA_BCC = "android.intent.extra.BCC";
  static const String EXTRA_CC = "android.intent.extra.CC";
  static const String EXTRA_CHANGED_COMPONENT_NAME =
      "android.intent.extra.CHANGED_COMPONENT_NAME";
  static const String EXTRA_DATA_REMOVED = "android.intent.extra.DATA_REMOVED";
  static const String EXTRA_DOCK_STATE = "android.intent.extra.DOCK_STATE";
  static const String EXTRA_DOCK_STATE_HE_DESK =
      "android.intent.extra.DOCK_STATE_HE_DESK";
  static const String EXTRA_DOCK_STATE_LE_DESK =
      "android.intent.extra.DOCK_STATE_LE_DESK";
  static const String EXTRA_DOCK_STATE_CAR =
      "android.intent.extra.DOCK_STATE_CAR";
  static const String EXTRA_DOCK_STATE_DESK =
      "android.intent.extra.DOCK_STATE_DESK";
  static const String EXTRA_DOCK_STATE_UNDOCKED =
      "android.intent.extra.DOCK_STATE_UNDOCKED";
  static const String EXTRA_DONT_KILL_APP =
      "android.intent.extra.DONT_KILL_APP";
  static const String EXTRA_EMAIL = "android.intent.extra.EMAIL";
  static const String EXTRA_INITIAL_INTENTS =
      "android.intent.extra.INITIAL_INTENTS";
  static const String EXTRA_INTENT = "android.intent.extra.INTENT";
  static const String EXTRA_KEY_EVENT = "android.intent.extra.KEY_EVENT";
  static const String EXTRA_ORIGINATING_URI =
      "android.intent.extra.ORIGINATING_URI";
  static const String EXTRA_PHONE_NUMBER = "android.intent.extra.PHONE_NUMBER";
  static const String EXTRA_REFERRER = "android.intent.extra.REFERRER";
  static const String EXTRA_REMOTE_INTENT_TOKEN =
      "android.intent.extra.REMOTE_INTENT_TOKEN";
  static const String EXTRA_REPLACING = "android.intent.extra.REPLACING";
  static const String EXTRA_SHORTCUT_ICON =
      "android.intent.extra.shortcut.ICON";
  static const String EXTRA_SHORTCUT_ICON_RESOURCE =
      "android.intent.extra.shortcut.ICON_RESOURCE";
  static const String EXTRA_SHORTCUT_INTENT =
      "android.intent.extra.shortcut.INTENT";
  static const String EXTRA_STREAM = "android.intent.extra.STREAM";
  static const String EXTRA_SHORTCUT_NAME =
      "android.intent.extra.shortcut.NAME";
  static const String EXTRA_SUBJECT = "android.intent.extra.SUBJECT";
  static const String EXTRA_TEMPLATE = "android.intent.extra.TEMPLATE";
  static const String EXTRA_TEXT = "android.intent.extra.TEXT";
  static const String EXTRA_TITLE = "android.intent.extra.TITLE";
  static const String EXTRA_UID = "android.intent.extra.UID";
  static const String EXTRA_USER_INITIATED =
      "android.intent.extra.USER_INITIATED";
}
