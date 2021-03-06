
import 'package:flutter/material.dart';
import 'package:newsdx/router/ui_pages.dart';
import 'dart:developer' as developer;

class NewsDxRouteParser extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(RouteInformation routeInformation) async {

    developer.log(Log_Tag , name: "RouteParser :: parseRouteInformation()");

    final uri = Uri.parse(routeInformation.location!);
    if (uri.pathSegments.isEmpty) {
      return SplashPageConfig;
    }

    final path = '/${uri.pathSegments[0]}';
    switch (path) {
      case SplashPath:
        return SplashPageConfig;
      case LoginPath:
        return LoginPageConfig;
      case OtpPath:
        return OtpPageConfig;
      case HomePath:
        return HomePageConfig;
      case SubscriptionPlanScreenPath:
        return SubscriptionPlanPageConfig;
      case UserProfileScreenPath:
        return UserProfileInfoPageConfig;
      case ArticleDe:
        return ArticleDetailPageConfig;
      case BookMarkScreenPath:
        return BookMarkPageConfig;
      case NotificationScreenPath:
        return NotificationPageConfig;
      case HomeArticlDetailPath:
        return HomeArticleDetailPageConfig;
      default:
        return SplashPageConfig;
    }
  }

  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) {
    developer.log(Log_Tag , name: "RouteParser :: restoreRouteInformation()");
    switch(configuration.uiPage) {
      case Pages.Splash:
            return const RouteInformation(location: SplashPath);
      case Pages.Login:
          return const RouteInformation(location: LoginPath);
      case Pages.Otp:
        return const RouteInformation(location: OtpPath);
      case Pages.Home:
        return const RouteInformation(location: HomePath);
      case Pages.SubscriptionPlan:
        return const RouteInformation(location: SubscriptionPlanScreenPath);
      case Pages.ArticleDe:
        return const RouteInformation(location: ArticleDe);
      case Pages.BookMark:
        return const RouteInformation(location: BookMarkScreenPath );
      case Pages.Notification:
        return const RouteInformation(location: NotificationScreenPath);
      case Pages.HomeArticleDetail:
        return const RouteInformation(location: HomeArticlDetailPath);

      default: return const RouteInformation(location: SplashPath);
    }
  }
}