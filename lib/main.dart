import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:loggy/loggy.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/database/data_helper.dart';
import 'package:newsdx/model/notification_register.dart';
import 'package:newsdx/preference/user_preference.dart';
import 'package:newsdx/router/app_state.dart';
import 'package:newsdx/router/back_dispatcher.dart';
import 'package:newsdx/router/route_parser.dart';
import 'package:newsdx/router/router_delegate.dart';
import 'package:newsdx/router/ui_pages.dart';
import 'package:newsdx/screens/home_section_article_detail.dart';
import 'package:newsdx/viewmodel/Article_list_view_model.dart';
import 'package:newsdx/viewmodel/HomeSectionViewModel.dart';
import 'package:newsdx/viewmodel/sections_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;


AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel', //id
  'High importance notification',
  description: 'This channel is used for important notification',
  importance: Importance.high,
  playSound: true,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

// late MyObjectBox objectbox;

Future<void> main() async {


  Loggy.initLoggy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await Prefs.init();
  // await MyObjectBox.init();
  await Helpers.init();
  runApp(const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FirebaseMessaging firebaseMessaging;
  final appState = AppState();
  late NewsDxRouterDelegate delegate;
  late NewsDxBackButtonDispatcher backButtonDispatcher;
  late NewsDxRouteParser parser;
  late StreamSubscription _linkSubscription;

  _MyAppState() {
    delegate = NewsDxRouterDelegate(appState);
    backButtonDispatcher = NewsDxBackButtonDispatcher(delegate);
    parser = NewsDxRouteParser();
  }

  _requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: false,
      badge: true,
      sound: true,
    );
  }

  @override
  initState() {
    super.initState();
    initPlatformState();


      firebaseMessaging = FirebaseMessaging.instance;


    firebaseMessaging.getToken().then((value) {
       if (kDebugMode) {
         print(value);
       }
       Prefs.saveFcmToken(value);
       if(!Prefs.getIsFcmTokenSent()) {
         sendFcmToken(value);
       }
    });


    if (Platform.isIOS) {
      _requestIOSPermission();
    }

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        if (Prefs.getNotificationState()!) {
          if (notification != null) {
            flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
                iOS: const IOSNotificationDetails(

                )
                ,),);
          }
        }
      });


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      String id = "";
      if(message.data['type'] == "article"){
        id = message.data['article_id'];
        appState.currentAction = PageAction(
            state: PageState.addWidget,
            widget: HomeSectionArticleDetail(
              homeArticle: id,
              bookmarkStatus: false,
            ),
            page: HomeArticleDetailPageConfig);
      }
      RemoteNotification? notification = message.notification;
      if (notification != null ) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    /*
    Setting Device orientation to portrait mode.
     */
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    developer.log(Log_Tag, name: "MyApp2State :: build()");

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => appState,
        ),
        ChangeNotifierProvider(create: (_) => SectionsViewModel()),
        ChangeNotifierProvider(create: (_) => ArticleListViewModel()),
        ChangeNotifierProvider(create: (_) => HomeSectionsViewModel()),
      ],
      child: MaterialApp.router(
              routeInformationParser: parser,
              routerDelegate: delegate,
              backButtonDispatcher: backButtonDispatcher,
              debugShowCheckedModeBanner: false,
              title: MyConstant.appName,
            ),
          );
  }

  Future<void> initPlatformState() async {
    // Attach a listener to the Uri links stream
    _linkSubscription = uriLinkStream.listen((Uri? uri) {
      if (!mounted) return;
      setState(() {
        delegate.parseRoute(uri!);
      });
    }, onError: (Object err) {
      if (kDebugMode) {
        print('Got error $err');
      }
    });
  }

  @override
  void dispose() {
    _linkSubscription.cancel();
    super.dispose();
  }


  Future<bool?> sendFcmToken(String? fcmToken) async {
    String? getAccessToken = MyConstant.propertyToken;
    var url = Uri.parse(MyConstant.fcmToken);
    final response = await http.post(
      url,
      body: {"deviceToken": fcmToken},
      headers: {
        "Authorization": getAccessToken,
      },
    );
    NotificationRegistration notificationRegistration = modelClassToJson(response.body);
    if(notificationRegistration.status == true){
      Prefs.isFcmTokenSent(true);
    } else{
      Prefs.isFcmTokenSent(false);
    }
    return notificationRegistration.status;
  }
  NotificationRegistration modelClassToJson(String str) =>
      NotificationRegistration.fromJson(const JsonDecoder().convert(str));
}
