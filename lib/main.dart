import 'package:c2sgithub/redux/actions/api.action.dart';
import 'package:c2sgithub/redux/middleware/api.middleware.dart';
import 'package:c2sgithub/redux/reducers/api.reducer.dart';
import 'package:c2sgithub/redux/states/api.state.dart';
import 'package:c2sgithub/ui/app.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    App(
      store: Store<ApiState>(
        apiReducer,
        initialState: ApiState.loading(),
        middleware: [ApiMiddleware()],
      ).dispatch(ApiAction.retrieveProfile()),
    ),
  );
}
