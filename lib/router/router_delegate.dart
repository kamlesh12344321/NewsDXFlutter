
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newsdx/router/app_state.dart';
import 'package:newsdx/router/back_dispatcher.dart';
import 'package:newsdx/router/router_delegate.dart';
import 'package:newsdx/router/ui_pages.dart';
import 'package:newsdx/screens/home_screen.dart';
import 'package:newsdx/screens/login_screen.dart';
import 'package:newsdx/screens/otp_screen.dart';
import 'package:newsdx/screens/splash_screen.dart';
import 'dart:developer' as developer;

import 'package:newsdx/subscription/subscriprtion_plan_screen.dart';

class NewsDxRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  final List<Page> _pages = [];
  NewsDxBackButtonDispatcher? backButtonDispatcher;
  AppState? appState;

  @override
  GlobalKey<NavigatorState>? navigatorKey;

  NewsDxRouterDelegate(this.appState) : navigatorKey = GlobalKey() {
    appState?.addListener(() {
      notifyListeners();
    });
  }

  // Getter for a list that cannot be modified.
  List<MaterialPage> get pages => List.unmodifiable(_pages);

  int numPages() => _pages.length;

  @override
  PageConfiguration get currentConfiguration {
    if(_pages.isEmpty) {
      return  SplashPageConfig;
    }
    return _pages.last.arguments as PageConfiguration;
  }

  void push(PageConfiguration? newRoute) {
    addPage(newRoute);
  }

  @override
  Widget build(BuildContext context) {
    developer.log(Log_Tag , name: "RouterDelegate :: build()");
    return Navigator(
      key: navigatorKey,
      onPopPage: _onPopUp,
      pages: buildPages(),
    );
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration? configuration) {
    developer.log(Log_Tag , name: "RouterDelegate :: setNewRoutePath()");
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).uiPage !=
            configuration?.uiPage;
    if (shouldAddPage) {
      _pages.clear();
      addPage(configuration);
    }
    return SynchronousFuture(null);
  }

  void parseRoute(Uri uri) {
    if (uri.pathSegments.isEmpty) {
      setNewRoutePath(SplashPageConfig);
      return;
    }
  }

  void setPath(List<MaterialPage> path) {
    _pages.clear();
    _pages.addAll(path);
  }

  void replace(PageConfiguration? newRoute) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    addPage(newRoute);
  }

  List<Page> buildPages() {
    developer.log(Log_Tag , name: "RouterDelegate :: buildPages()");
    if (!appState!.splashFinished) {
      replaceAll(SplashPageConfig);
    } else {
      switch (appState!.currentAction.state) {
        case PageState.none:
          break;
        case PageState.addPage:
          _setPageAction(appState!.currentAction);
          addPage(appState!.currentAction.page);
          break;
        case PageState.pop:
          pop();
          break;

        case PageState.replace:
          _setPageAction(appState!.currentAction);
          replace(appState?.currentAction.page);
          break;

        case PageState.replaceAll:
          _setPageAction(appState!.currentAction);
          replaceAll(appState!.currentAction.page);
          break;

        case PageState.addWidget:
          _setPageAction(appState!.currentAction);
          pushWidget(
              appState!.currentAction.widget, appState!.currentAction.page);
          break;
        case PageState.addAll:
          addAll(appState?.currentAction.pages);
          break;
      }
    }
    appState!.resetCurrentAction();

    return List.of(_pages);
  }

  void addAll(List<PageConfiguration>? routes) {
    _pages.clear();
    routes!.forEach((route) {
      addPage(route);
    });
  }

  void pushWidget(Widget? child, PageConfiguration? newRoute) {
    _addPageData(child, newRoute);
  }


  _setPageAction(PageAction action) {
    switch (action.page?.uiPage) {
      case Pages.Splash:
        SplashPageConfig.currentPageAction = action;
        break;
      case Pages.Login:
        LoginPageConfig.currentPageAction = action;
        break;
      case Pages.Otp:
        OtpPageConfig.currentPageAction = action;
        break;
      case Pages.Home:
        HomePageConfig.currentPageAction = action;
        break;
      case Pages.SubscriptionPlan:
        SubscriptionPlanPageConfig.currentPageAction = action;
        break;
      default:
        break;
    }
  }

  addPage(PageConfiguration? pageConfig) {
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).uiPage !=
            pageConfig?.uiPage;
    if (shouldAddPage) {
      switch (pageConfig!.uiPage) {
        case Pages.Splash:
          _addPageData(Splash(), SplashPageConfig);
          break;

        case Pages.Login:
          _addPageData(LoginScreen(), LoginPageConfig);
          break;

        case Pages.Otp:
          _addPageData(OTPScreen(), OtpPageConfig);
          break;

        case Pages.Home:
          _addPageData(HomeScreen(), HomePageConfig);
          break;

        case Pages.SubscriptionPlan:
          _addPageData(SubscriptionPlanScreen(),SubscriptionPlanPageConfig);
          break;

        default:
          break;
      }
    }
    notifyListeners();
  }

  Future<bool> popRoute() {
    if (canPop()) {
      _removePage(_pages.last as MaterialPage);
      return Future.value(true);
    }
    return Future.value(false);
  }

  MaterialPage _createPage(Widget? child, PageConfiguration? pageConfig) {
    return MaterialPage(
        child: child!,
        key: ValueKey(pageConfig!.key),
        name: pageConfig.path,
        arguments: pageConfig);
  }

  _addPageData(Widget? child, PageConfiguration? pageConfig) {
    _pages.add(_createPage(child, pageConfig));
  }

  replaceAll(PageConfiguration? newRoute) {
    setNewRoutePath(newRoute);
  }

  bool _onPopUp(Route<dynamic> route, result) {
    developer.log(Log_Tag , name: "RouterDelegate :: _onPopUp()");
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    if (canPop()) {
      pop();
      return true;
    } else {
      return false;
    }
  }

  bool canPop() {
    return _pages.length > 1;
  }

  void pop() {
    if (canPop()) {
      _removePage(_pages.last as MaterialPage);
    }
  }

  _removePage(MaterialPage? page) {
    if (page != null) {
      _pages.remove(page);
      notifyListeners();
    }
  }

  bool _onPopPage(Route<dynamic> route, result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    if (canPop()) {
      pop();
      return true;
    } else {
      return false;
    }
  }
}
