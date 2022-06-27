import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/apple/auth_service.dart';
import 'package:newsdx/preference/user_preference.dart';
import 'package:newsdx/router/app_state.dart';
import 'package:newsdx/router/back_dispatcher.dart';
import 'package:newsdx/router/route_parser.dart';
import 'package:newsdx/router/router_delegate.dart';
import 'package:newsdx/router/ui_pages.dart';
import 'package:newsdx/viewmodel/Article_list_view_model.dart';
import 'package:newsdx/viewmodel/HomeSectionViewModel.dart';
import 'package:newsdx/viewmodel/generic_list_view_model.dart';
import 'package:newsdx/viewmodel/sections_list_view_model.dart';
import 'package:newsdx/viewmodel/sport_stars_view_model.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:developer' as developer;

import 'apple/apple_sign_in_available.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Prefs.init();
  final appleSignInAvailable = await AppleSignInAvailable.check();
  runApp(Provider<AppleSignInAvailable>.value(value: appleSignInAvailable,
  child: MyApp(),));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        // ChangeNotifierProvider(create: (_) => ArticleListViewModel()),
        // ChangeNotifierProvider(create: (_) => SportStarsViewModel()),
        // ChangeNotifierProvider(create: (_) => GenericViewModel()),
        ChangeNotifierProvider(create: (_) => HomeSectionsViewModel()),
        Provider(create: (_) => AuthService())
      ],
      child: MaterialApp.router(
        routeInformationParser: parser,
        routerDelegate: delegate,
        backButtonDispatcher: backButtonDispatcher,
        debugShowCheckedModeBanner: false,
        title: MyConstant.appName,
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );

    /*return ChangeNotifierProvider(
        create: (_) => appState,
        child: MaterialApp.router(
          routeInformationParser: parser,
          routerDelegate: delegate,
          backButtonDispatcher: backButtonDispatcher,
          debugShowCheckedModeBanner: false,
          title: MyConstant.appName,
          theme: ThemeData(
            textTheme: GoogleFonts.latoTextTheme(
              Theme.of(context).textTheme,
            ),
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
        ),
    );*/
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
}
