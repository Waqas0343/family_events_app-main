import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'app/app_styles/complete_app_theme.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/services/app_services.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Initialize other services
    await Services().initServices();
    await initializeNotifications();

    // Initialize Crashlytics
    final crashlytics = FirebaseCrashlytics.instance;

    // Conditionally enable Crashlytics collection based on appTrackingTransparency permission
    if (await Permission.appTrackingTransparency.request().isGranted) {
      crashlytics.setCrashlyticsCollectionEnabled(true);
    } else {
      crashlytics.setCrashlyticsCollectionEnabled(false);
    }
  } catch (e) {
    // Handle Firebase initialization errors
    if (kDebugMode) {
      print("Firebase initialization failed: $e");
    }
  }

  // Disable logging in release mode
  if (kReleaseMode) {
    Get.isLogEnable = false;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.splash,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      theme: AppThemeInfo.themeData,
    );
  }
}
