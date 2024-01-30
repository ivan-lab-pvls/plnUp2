import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:jungle_riches_app/core/config.dart';
import 'package:jungle_riches_app/core/notes.dart';
import 'package:jungle_riches_app/core/notys.dart';
import 'package:jungle_riches_app/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: AppFirebaseOptions.currentPlatform);

  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));

  await FirebaseRemoteConfig.instance.fetchAndActivate();

  await NotificationsFirebase().activate();

  tz.initializeTimeZones();

  final now = DateTime.now();

  final eight =
      now.copyWith(hour: 8, minute: 0, second: 0).add(const Duration(days: 1));
  final ten =
      now.copyWith(hour: 10, minute: 0, second: 0).add(const Duration(days: 1));
  final twelve =
      now.copyWith(hour: 12, minute: 0, second: 0).add(const Duration(days: 1));
  final sixteen =
      now.copyWith(hour: 16, minute: 0, second: 0).add(const Duration(days: 1));
  final eighteen =
      now.copyWith(hour: 18, minute: 0, second: 0).add(const Duration(days: 1));

  LocalNotifyService()
      .scheduleNotification(scheduledNotificationDateTime: eight);
  LocalNotifyService().scheduleNotification(scheduledNotificationDateTime: ten);
  LocalNotifyService()
      .scheduleNotification(scheduledNotificationDateTime: twelve);
  LocalNotifyService()
      .scheduleNotification(scheduledNotificationDateTime: sixteen);
  LocalNotifyService()
      .scheduleNotification(scheduledNotificationDateTime: eighteen);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom,
  ]);

  await showStarsJumeira();

  runApp(const MyApp());
}

late SharedPreferences prefJumeira;
final rateJumeira = InAppReview.instance;

Future<void> showStarsJumeira() async {
  await getJumairaCacheRateIs();
  bool alreadyRated = prefJumeira.getBool('jumeira') ?? false;
  if (!alreadyRated) {
    if (await rateJumeira.isAvailable()) {
      rateJumeira.requestReview();
      await prefJumeira.setBool('jumeira', true);
    }
  }
}

Future<void> getJumairaCacheRateIs() async {
  prefJumeira = await SharedPreferences.getInstance();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
