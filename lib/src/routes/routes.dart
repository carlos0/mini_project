import 'package:mini_proyect/src/screens/home_screen.dart';
import 'package:mini_proyect/src/screens/login_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    "/": (context) => const LoginScreen(),
    "/home": (context) => const HomeScreen(),
  };
}
