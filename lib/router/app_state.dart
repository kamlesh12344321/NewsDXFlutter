import 'package:flutter/material.dart';
import 'package:newsdx/preference/user_preference.dart';
import 'package:newsdx/router/ui_pages.dart';
import 'dart:developer' as developer;


enum PageState { none, addPage, addAll, replace, replaceAll, pop, addWidget }

class PageAction {
  PageState? state;
  PageConfiguration? page;
  List<PageConfiguration>? pages;
  Widget? widget;

  PageAction({this.state, this.page, this.pages, this.widget});
}

class AppState extends ChangeNotifier {
  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;

  bool _splashFinished = false;

  bool get splashFinished => _splashFinished;

  PageAction _currentAction = PageAction();

  PageAction get currentAction => _currentAction;

  set currentAction(PageAction action) {
    _currentAction = action;
    notifyListeners();
  }

  AppState() {
    _loggedIn = Prefs.getIsLoggedIn();
  }

  resetCurrentAction() {
    _currentAction = PageAction();
  }

  setSplashFinished() {
    developer.log(Log_Tag , name: "###########################");
    developer.log(Log_Tag , name: "AppState :: setSplashFinished()");
    _splashFinished = true;

    bool onBoardingStatus =  Prefs.getOnBoarding();
    if(onBoardingStatus) {
      _currentAction = PageAction(state: PageState.replaceAll, page: HomePageConfig);
    } else {
      _currentAction = PageAction(state: PageState.replaceAll, page:OnBoardingPageConfig);
    }

    notifyListeners();
  }

  void login( bool isSocialLoggedIn) {
    _loggedIn = true;
    saveLoginState(loggedIn);
    if(isSocialLoggedIn){
      _currentAction = PageAction(state: PageState.replaceAll, page: HomePageConfig);
    } else {
      _currentAction =
          PageAction(state: PageState.addPage, page: OtpPageConfig);
    }
    notifyListeners();
  }
  void saveLoginState(bool loggedIn) async {
   Prefs.saveIsLoggedIn(loggedIn);
  }
}
