
import 'package:flutter/foundation.dart';
import 'package:newsdx/router/app_state.dart';
import 'package:newsdx/router/ui_pages.dart';


const String Log_Tag = 'ROUTER';

const String SplashPath = '/splash';
const String LoginPath = '/login';
const String OtpPath = '/otp';
const String HomePath = '/home';
const String SubscriptionPlanScreenPath = '/subscription';
const String UserProfileScreenPath = '/userProfileInfo';

enum Pages {
      Splash,
      Login,
      Otp,
      Home,
      SubscriptionPlan,
      UserProfileInfo
}

class PageConfiguration {

final String key;
final String path;
final Pages uiPage;
PageAction ?currentPageAction;

      // PageConfiguration({required this.key, required this.path, required this.uiPath,  this.currentPageAction});

PageConfiguration(
    {required this.key, required this.path, required this.uiPage, this.currentPageAction});
}

PageConfiguration SplashPageConfig = PageConfiguration(key: 'Splash', path: SplashPath, uiPage: Pages.Splash, currentPageAction: null);
PageConfiguration LoginPageConfig = PageConfiguration(key: 'login', path: SplashPath, uiPage: Pages.Login, currentPageAction: null);
PageConfiguration OtpPageConfig = PageConfiguration(key: 'otp', path: SplashPath, uiPage: Pages.Otp, currentPageAction: null);
PageConfiguration HomePageConfig = PageConfiguration(key: 'home', path: SplashPath, uiPage: Pages.Home, currentPageAction: null);
PageConfiguration SubscriptionPlanPageConfig = PageConfiguration(key: 'subscription', path: SplashPath, uiPage: Pages.SubscriptionPlan, currentPageAction: null);
PageConfiguration UserProfileInfoPageConfig = PageConfiguration(key: 'userProfileInfo', path: SplashPath, uiPage: Pages.UserProfileInfo, currentPageAction: null);

