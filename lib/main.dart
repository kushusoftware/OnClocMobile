import 'dart:async';
import 'dart:io' show Platform;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_activity_recognition/flutter_activity_recognition.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/store/main_store.dart';
import 'package:on_cloc_mobile/app/controllers/theme/theme_controller.dart';
import 'package:on_cloc_mobile/app/services/api/api_service.dart';
import 'package:on_cloc_mobile/app/services/db/work_tracking_service.dart';
import 'package:on_cloc_mobile/app/services/helper/shared_helper.dart';
import 'package:on_cloc_mobile/app/services/location/location_service.dart';
import 'package:on_cloc_mobile/app/services/offline/offline_sync_service.dart';
import 'package:on_cloc_mobile/app/services/tracking/tracking_service.dart';
import 'package:on_cloc_mobile/locale/languages.dart';
import 'package:on_cloc_mobile/locale/locale_key.dart';
import 'package:on_cloc_mobile/locale/localization.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';
import 'package:on_cloc_mobile/utilities/routes.dart';

OnClocMainStore mainStore = OnClocMainStore();
OnClocApiService onClocApiService = OnClocApiService();
WorkTrackingService onClocDbService = WorkTrackingService();
OnClocSharedHelper onClocSharedHelper = OnClocSharedHelper();
OnClocTrackingService onClocTrackingService = OnClocTrackingService();
OnClocOfflineSyncService onClocOfflineSyncService = OnClocOfflineSyncService();
StreamSubscription<Activity>? _activityStreamSubscription;

final DateFormat onClocFormatter = DateFormat('dd-MM-yyyy');
final _activityStreamController = StreamController<Activity>();

late OnClocLocaleKey onClocLocale;
late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize(aLocaleLanguageList: supportedLanguages());
  await GetStorage.init();

  if (!isWeb) {
    await setupFlutterNotifications();
  }
  await initializeBackgroundService();

  defaultToastGravityGlobal = ToastGravity.BOTTOM;
  defaultToastBackgroundColor = onClocEditTextBgColor;
  defaultToastTextColor = onClocWhiteColor;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const OnClocApp());
  });
}

class OnClocApp extends StatefulWidget {
  const OnClocApp({super.key});

  @override
  OnClocAppState createState() => OnClocAppState();
}

class OnClocAppState extends State<OnClocApp> {
  final OnClocThemeController themeController = Get.put(
    OnClocThemeController(),
  );
  OnClocMainStore mainController = Get.put(OnClocMainStore());

  @override
  void initState() {
    super.initState();
    mainController.setLanguage(defaultLanguage);
    onClocTrackingService.startLocationTrackingService();
  }

  @override
  void dispose() {
    onClocTrackingService.stopLocationTrackingService();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Get.isDarkMode
            ? Brightness.light
            : Brightness.dark,
        statusBarIconBrightness: Get.isDarkMode
            ? Brightness.light
            : Brightness.dark,
      ),
    );
    return Obx(
      () => GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: themeController.isDarkMode
            ? OnClocTheme.darkTheme
            : OnClocTheme.lightTheme,
        title: '$mainAppName${!isMobile ? ' ${platformName()}' : ''}',
        localizationsDelegates: const [
          OnClocLocalization(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: Get.deviceLocale,
        fallbackLocale: const Locale('en', 'GB'),
        localeResolutionCallback: (locale, supportedLocales) => locale,
        getPages: OnClocRoutes.routes,
        initialRoute: OnClocRoutes.onClocSplashScreen,
      ),
    );
  }
}

Future<void> initializeBackgroundService() async {
  final service = FlutterBackgroundService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId,
    notificationFgChannelName,
    description: notificationChannelDescription,
    importance: Importance.low,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (Platform.isIOS) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(iOS: DarwinInitializationSettings()),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);

  initializeService();
  service.startService();
}

void _onActivityReceive(Activity activity) {
  log(
    'Activity Received >> ${activity.type} Confidence ${activity.confidence}',
  );
  var latitude = getDoubleAsync(latitudePref);
  var longitude = getDoubleAsync(longitudePref);
  var count = getIntAsync(activityCountPref);
  var isTracking = getBoolAsync(isTrackingOnPref);
  setValue(activityCountPref, count + 1);
  if (isTracking) {
    onClocTrackingService.updateWorkStatus(activity, latitude, longitude);
  }
  _activityStreamController.sink.add(activity);
}

void _handleActivityError(dynamic error) {
  log('Catch Activity Error >> $error');
}

void startBackgroundService() async {
  final service = FlutterBackgroundService();
  if (!await service.isRunning()) {
    service.startService();
  }
}

void stopBackgroundService() async {
  final service = FlutterBackgroundService();
  if (await service.isRunning()) {
    service.invoke('stopService');
  }
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);

  isFlutterLocalNotificationsInitialized = true;
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
    androidConfiguration: AndroidConfiguration(
      autoStart: true,
      autoStartOnBoot: true,
      onStart: onStart,
      isForegroundMode: true,
      notificationChannelId: notificationChannelId,
      initialNotificationTitle: notificationBgChannelName,
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: notificationId,
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.reload();
  final log = preferences.getStringList('log') ?? <String>[];
  log.add(DateTime.now().toIso8601String());
  await preferences.setStringList('log', log);

  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  try {
    DartPluginRegistrant.ensureInitialized();
    await initialize();
    SharedPreferences preferences = await SharedPreferences.getInstance();

    //Activity Tracker
    var activityRecognition = FlutterActivityRecognition.instance;
    _activityStreamSubscription = activityRecognition.activityStream
        .handleError(_handleActivityError)
        .listen(_onActivityReceive);

    /// OPTIONAL when use custom notification
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });

      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }

    service.on('stopService').listen((event) {
      _activityStreamSubscription?.cancel();
      service.stopSelf();
    });

    var isSettingsRefreshed =
        preferences.getBool(isSettingsRefreshedPref) ?? false;
    if (!isSettingsRefreshed) {
      onClocSharedHelper.refreshAppSettings();
    }
    //Set the update interval here
    Timer.periodic(onClocSharedHelper.getUpdateIntervalDuration(), (
      timer,
    ) async {
      //backgroundCallback();
      String message = 'error';
      try {
        await preferences.reload();
        var canTrack = preferences.getBool(isTrackingOnPref);
        var isLoggedIn = preferences.getBool(isLoggedInPref);
        var latitude = preferences.getDouble(latitudePref);
        var longitude = preferences.getDouble(longitudePref);
        var locCount = preferences.getInt(locationCountPref);
        var actCount = preferences.getInt(activityCountPref);
        var now = DateTime.now();
        final DateFormat formatter = DateFormat('jms');
        final String formattedTime = formatter.format(now);

        bool isTrackingEnabled =
            (isLoggedIn != null && isLoggedIn) &&
            (canTrack != null && canTrack);

        if (isTrackingEnabled) {
          //Device Update
          try {
            onClocTrackingService.updateDeviceStatus(
              latitude ?? 0.0,
              longitude ?? 0.0,
            );
          } catch (e) {
            message = 'Unable to update device status';
          }
          message =
              'Tracking : ${canTrack.toString()} UpdatedAt: $formattedTime LC: $locCount AC: $actCount';
        } else {
          message = 'Tracking is disabled';
          service.stopSelf();
        }
      } catch (e) {
        message = e.toString();
      }
      if (service is AndroidServiceInstance) {
        if (await service.isForegroundService()) {
          flutterLocalNotificationsPlugin.show(
            notificationId,
            notificationBgChannelName,
            message,
            const NotificationDetails(
              android: AndroidNotificationDetails(
                notificationChannelId,
                notificationFgChannelName,
                icon: 'ic_bg_service_small',
                ongoing: true,
              ),
            ),
          );
        }
      }
    });
  } catch (e) {
    log('BG Tracking Main Exception $e');
  }
}

@pragma('vm:entry-point')
void backgroundCallback() async {
  var locationData = await onClocTrackingService.locationInfo.getLocation();
  () async => Repo().update(locationData);
}
