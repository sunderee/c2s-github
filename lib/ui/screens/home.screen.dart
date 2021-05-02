import 'package:c2sgithub/redux/reducers/api.reducer.dart';
import 'package:c2sgithub/redux/states/api.state.dart';
import 'package:c2sgithub/ui/widgets/profile.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class HomeScreen extends StatelessWidget {
  static const String ROUTE_NAME = '/';

  @override
  Widget build(BuildContext context) {
    final store = Store<ApiState>(apiReducer, initialState: ApiState.loading());

    return Scaffold(
      appBar: AppBar(
        title: Text('C2SGitHub'),
      ),
      body: StoreProvider(
        store: store,
        child: Container(),
      ),
    );
  }
}
