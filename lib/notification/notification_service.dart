import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../services/storageFunctions.dart';


class NotificationServices {
  String? fcmToken;

  Future<void> getFCM() async {
    await FirebaseMessaging.instance.getToken().then((token) async {
      fcmToken = token;
      await StorageFunctions().setValue(firebaseToken, token);
      print("FireBase Token :$token");
    });
  }

  Future<void> initInfo() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, sound: true, badge: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      // TODO: handle the received notifications
    } else {
      print('User declined or has not accepted permission');
    }
    // var androidInitialize=const AndroidInitializationSettings('@mipmap/ic_launcher');}

    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitialize = DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: (
          e,
          r,
          w,
          d,
        ) {
          print("--$e--$r--$w--$d");
        });
    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    FlutterLocalNotificationsPlugin().initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) async {
      // if(payload!=null){
      //   print('PayLoad---------------');
      //   var message=await jsonDecode(payload);
      //   if(message['type']=='NEW_MESSAGE'){
      //     Navigator.pushNamed(context, InnerChatScreen.route,arguments: {'id':message['user_id'],'connection_id':message['connection_id']});
      //   }else if(message['type']=='NEW_BOOKING'){
      //     Provider.of<CurrentPage>(context,listen: false).setCurrentPage(pageNo: 1,tabIndex: 1);
      //     Navigator.popUntil(context, ModalRoute.withName('/bottom-nav'));
      //   }else{
      //     // if(remoteMessage.data['type']=='BROADCAST_EMAIL'||remoteMessage.data['type']=='BROADCAST_PUSH'){
      //     Navigator.pushNamed(context, NotificationScreen.route);
      //     // }
      //   }
      // }
    });
    DarwinNotificationDetails iosNotificationDetails =
        const DarwinNotificationDetails(
      threadIdentifier: "Pudo",
    );
    FirebaseMessaging.onMessage.listen((remoteMessage) async {
      print(remoteMessage.notification);
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
          remoteMessage.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: remoteMessage.notification?.title,
          htmlFormatContentTitle: true);
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails('Pudo', 'Pudo',
              styleInformation: bigTextStyleInformation,
              playSound: true,
              priority: Priority.high,
              importance: Importance.high);
      NotificationDetails platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iosNotificationDetails);
      if (!Platform.isIOS)
        await FlutterLocalNotificationsPlugin().show(
            0,
            remoteMessage.notification?.title,
            remoteMessage.notification?.body,
            platformChannelSpecifics,
            payload: jsonEncode(remoteMessage.data));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print(event);
    });
  }
}
