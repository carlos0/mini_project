import 'package:mini_proyect/src/routes/routes.dart';
import 'package:mini_proyect/src/screens/error_screen.dart';
import 'package:mini_proyect/src/themes/themes.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeClass.lightTheme,
      //darkTheme: ThemeClass.darkTheme,
      // themeMode: ThemeMode.system,
      routes: getRoutes(),
      initialRoute: "/",
      onGenerateRoute: (setting) {
        return MaterialPageRoute(builder: (context) {
          return const ErrorScreen();
        });
      },
    );
  }
}
