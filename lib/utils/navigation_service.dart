import 'package:flutter/material.dart';

class NavigationService{
  GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  static NavigationService instance = NavigationService();
  Future<dynamic>? navigateToReplacement(String route){
    return navigationKey.currentState?.pushReplacementNamed(route);
  }
  Future<dynamic>? navigateTo(String route){
    return navigationKey.currentState?.pushNamed(route);
  }
  Future<dynamic>? navigateToWithArgs(String route, argument){
    return navigationKey.currentState?.pushNamed(route, arguments: argument);
  }
  Future<dynamic>? navigateToRoute(MaterialPageRoute route){
    return navigationKey.currentState?.push(route);
  }

  goback(){
    return navigationKey.currentState?.pop();

  }
}
