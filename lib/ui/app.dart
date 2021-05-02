import 'package:c2sgithub/redux/states/api.state.dart';
import 'package:c2sgithub/ui/screens/home.screen.dart';
import 'package:c2sgithub/utils/constants/color.const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class App extends StatelessWidget {
  final Store<ApiState> store;

  const App({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return StoreProvider<ApiState>(
      store: store,
      child: MaterialApp(
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
        home: StoreProvider<ApiState>(
          store: store,
          child: HomeScreen(),
        ),
      ),
    );
  }
}
