import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loggy/loggy.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/apple/auth_service.dart';
import 'package:newsdx/model/notification_register.dart';
import 'package:newsdx/preference/user_preference.dart';
import 'package:newsdx/router/app_state.dart';
import 'package:newsdx/router/back_dispatcher.dart';
import 'package:newsdx/router/route_parser.dart';
import 'package:newsdx/router/router_delegate.dart';
import 'package:newsdx/router/ui_pages.dart';
import 'package:newsdx/screens/notification_detail.dart';
import 'package:newsdx/viewmodel/Article_list_view_model.dart';
import 'package:newsdx/viewmodel/HomeSectionViewModel.dart';
import 'package:newsdx/viewmodel/sections_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:developer' as developer;
import 'apple/apple_sign_in_available.dart';
import 'package:http/http.dart' as http;


AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel', //id
  'High importance notification',
  importance: Importance.high,
  playSound: true,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  Loggy.initLoggy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await Prefs.init();
  final appleSignInAvailable = await AppleSignInAvailable.check();
  runApp(Provider<AppleSignInAvailable>.value(
    value: appleSignInAvailable,
    child: const MyApp(),
  ));
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

  @override
  initState() {
    super.initState();
    initPlatformState();
    firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.getToken().then((value) {
       print(value);
       Prefs.saveFcmToken(value);
       if(!Prefs.getIsFcmTokenSent()) {
         sendFcmToken(value);
       }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      String id = "";
      if(message?.data['type'] == "article"){
        id = message?.data['article_id'];
        appState.currentAction = PageAction(
            state: PageState.addWidget,
            widget: NotificationArticleDetailScreen(articleIdFromNotification: id,),
            page: UserProfileInfoPageConfig);
      }
      if (notification != null && android != null) {
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
              icon:'@mipmap/ic_launcher',
            )));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      String id = "";
      if(message?.data['type'] == "article"){
        id = message?.data['article_id'];
        appState.currentAction = PageAction(
            state: PageState.addWidget,
            widget: NotificationArticleDetailScreen(articleIdFromNotification: id,),
            page: UserProfileInfoPageConfig);
      }
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
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
        Provider(create: (_) => AuthService())
      ],
      child: ThemeProvider(
        saveThemesOnChange: true,
        loadThemeOnInit: false,
        onInitCallback: (controller, previouslySavedThemeFuture) async {
          String? savedTheme = await previouslySavedThemeFuture;
          if (savedTheme != null) {
            controller.setTheme(savedTheme);
          } else {
            Brightness platformBrightness =
                SchedulerBinding.instance?.window.platformBrightness ??
                    Brightness.light;
            if (platformBrightness == Brightness.dark) {
              controller.setTheme('dark');
            } else {
              controller.setTheme('light');
            }
            controller.forgetSavedTheme();
          }
        },
        themes: <AppTheme>[
          AppTheme.light(id: 'light'),
          AppTheme.dark(id: 'dark'),
        ],
        child: ThemeConsumer(
          child: Builder(
            builder: (themeContext) => MaterialApp.router(
              routeInformationParser: parser,
              routerDelegate: delegate,
              backButtonDispatcher: backButtonDispatcher,
              debugShowCheckedModeBanner: false,
              title: MyConstant.appName,
              theme: ThemeProvider.themeOf(themeContext).data,
            ),
          ),
        ),
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
    var url = Uri.parse(MyConstant.Fcm_token);
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
      NotificationRegistration.fromJson(JsonDecoder().convert(str));
}
