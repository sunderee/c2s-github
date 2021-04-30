import 'package:c2sgithub/ui/screens/home.screen.dart';
import 'package:c2sgithub/utils/constants/color.const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: COLOR_PRODUCT,
        accentColor: COLOR_PRODUCT,
        scaffoldBackgroundColor: COLOR_BACKGROUND,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0.0,
        ),
      ),
      initialRoute: HomeScreen.ROUTE_NAME,
      routes: {
        HomeScreen.ROUTE_NAME: (_) => HomeScreen(),
      },
    );
  }
}
