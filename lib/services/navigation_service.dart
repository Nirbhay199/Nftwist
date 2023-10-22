import 'package:flutter/material.dart';
import 'package:nftwist/constant/toaster.dart';
import 'package:nftwist/services/locator.dart';
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();

  Future<dynamic> namedNavigateTo(String routeName, {dynamic arguments}) {
     return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }
  Future<dynamic> push(Route route) {
    return navigatorKey.currentState!.push(route);
  }

  void goBack({data}) {
    locator<Toaster>().snackbarKey.currentState?.removeCurrentSnackBar();
    return navigatorKey.currentState!.pop(data);
  }
  Future<dynamic> pushReplace(route) {
    return navigatorKey.currentState!.pushReplacement(route);
  }
  void popUntil(routeName) {
    return navigatorKey.currentState!.popUntil((route){
      return route.settings.name==routeName;
    });
  }
}
