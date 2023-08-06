import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class ScheduledNotification {
  getRemainderNotification({required int notiId, required String title, required String body}) async{
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: notiId,
            channelKey: 'notify',
            backgroundColor: Colors.black,
            title: 'Budget time',
            body: 'Its time to add your budget',
            wakeUpScreen: true,
            category: NotificationCategory.Message,
            notificationLayout: NotificationLayout.Inbox,
            payload: {'uuid': 'uuid-test'},
            autoDismissible: true,
            criticalAlert: true,
            locked: false,
            displayOnBackground: true,
            fullScreenIntent: true
        ),
    );


    AwesomeNotifications().actionStream.listen((event) async {
      print(event.toMap().toString());
      if(event.buttonKeyPressed=='Hang up'){
        await AwesomeNotifications().cancel(notiId);
      }
    });

  }
}