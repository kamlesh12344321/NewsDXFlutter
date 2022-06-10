import 'package:flutter/material.dart';
import 'package:newsdx/router/back_dispatcher.dart';
import 'package:newsdx/router/router_delegate.dart';

class NewsDxBackButtonDispatcher extends RootBackButtonDispatcher {

  final NewsDxRouterDelegate _routerDelegate;

  NewsDxBackButtonDispatcher(this._routerDelegate) : super();

  @override
  Future<bool> didPopRoute() {
    return _routerDelegate.popRoute();
  }
}