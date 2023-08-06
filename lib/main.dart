import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:budget_tracker/features/auth/auth_controller.dart';
import 'package:budget_tracker/screens/dashboard_screen.dart';
import 'package:budget_tracker/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';

import 'features/notifications/notify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'notify',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white,
            playSound: true,
            enableLights: true,
            defaultRingtoneType: DefaultRingtoneType.Ringtone,
            importance: NotificationImportance.High
        )
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  String? mToken = " ";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      print(event);

      if (event != null) {
        ScheduledNotification().getRemainderNotification(notiId: 4, title: '${event.data}', body: '${event.data}');
      }
    });

    FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        mToken = value;
      });
      log("Here the generated token is ${mToken}");
    });



    // Foregrand State
    FirebaseMessaging.onMessage.listen((event) {

    });

    // Background State
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      //LocalNotificationService.showNotificationOnForeground(event);
    ScheduledNotification().getRemainderNotification( notiId: 6, title: '${event.data}', body: '${event.data}');
      });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ref.watch(userAuthProvider).when(
          data: (user) {
            if(user == null){
              return LoginPage();
            }else{
              return DashboardScreen();
            }
          }, error: (err, trace) {
        print("here $err with the stack is $trace");
        return Container();
      }, loading: () {
        return Container(child: Center(child: CircularProgressIndicator(),),);
      }) ,
    );
  }
}




