import 'package:c2sgithub/ui/screens/home.screen.dart';
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
      theme: ThemeData(),
      initialRoute: HomeScreen.ROUTE_NAME,
      routes: {
        HomeScreen.ROUTE_NAME: (_) => HomeScreen(),
      },
    );
  }
}
