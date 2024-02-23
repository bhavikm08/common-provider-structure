import 'dart:io';

import 'package:common/Common/firebase_common.dart';
import 'package:common/Screens/Loader/loading_provider.dart';
import 'package:common/local_notification/local_notification.dart';
import 'package:common/screens/home/home_provider.dart';
import 'package:common/screens/home/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/Loader/loading_screen.dart';
import 'Screens/users/users_provider.dart';
import 'network_connectivity /network_connectivity.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInit();
  await LocalNotifications.init();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

Future<void> firebaseInit() async {
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: FirebaseCommon.apiKey,
        appId: FirebaseCommon.appId,
        messagingSenderId: FirebaseCommon.messagingSenderId,
        projectId: FirebaseCommon.projectId,
      ),
    );
  } else if (Platform.isIOS) {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoadingProviders>(
            create: (context) => LoadingProviders()),

        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider<NetworkStatusService>(
          create: (context) => NetworkStatusService(),
        ),
        ChangeNotifierProvider<UsersProvider>(
          create: (context) => UsersProvider(),
        ),
      ],
      child: const MaterialApp(
        // builder: (context, child) {
        //   return Loading(child: child);
        // },
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
