import 'package:c2sgithub/api/models/headline.model.dart';
import 'package:c2sgithub/api/models/repo.model.dart';
import 'package:c2sgithub/redux/actions/api.action.dart';
import 'package:c2sgithub/redux/middleware/api.middleware.dart';
import 'package:c2sgithub/redux/reducers/api.reducer.dart';
import 'package:c2sgithub/redux/states/api.state.dart';
import 'package:c2sgithub/ui/widgets/profile.widget.dart';
import 'package:c2sgithub/utils/tuple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class HomeScreen extends StatelessWidget {
  static const String ROUTE_NAME = '/';

  @override
  Widget build(BuildContext context) {
    StoreProvider.of<ApiState>(context).dispatch(ApiAction.retrieveProfile());
    return Scaffold(
      appBar: AppBar(
        title: Text('C2SGitHub'),
      ),
      body: StoreConnector<ApiState, _HomeScreenViewModel>(
        converter: (store) => _HomeScreenViewModel(store.state),
        builder: (BuildContext cntx, _HomeScreenViewModel viewModel) {
          if (viewModel.state is LoadingApiState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (viewModel.state is ErrorApiState) {
            final state = viewModel.state as ErrorApiState;
            return Center(
              child: Text(state.exception ?? 'Unknown application error'),
            );
          } else if (viewModel.state is SuccessfulApiState) {
            final state = viewModel.state as SuccessfulApiState;
            final stateDataObject =
                state.data as Triple<HeadlineModel, List<RepoModel>, int>;
            final headline = stateDataObject.first;

            return SafeArea(
              minimum: const EdgeInsets.all(16.0),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ProfileWidget(
                    avatarURL: headline.avatarURL ?? '',
                    fullName: headline.fullName ?? '',
                    username: headline.username ?? '',
                    bio: headline.bio ?? '',
                    followers: headline.followers ?? 0,
                    following: headline.following ?? 0,
                    stars: stateDataObject.third,
                    company: headline.company,
                    location: headline.location,
                    website: headline.website,
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Text('Fatal error, restart the app'),
            );
          }
        },
      ),
    );
  }
}

class _HomeScreenViewModel {
  final ApiState state;

  const _HomeScreenViewModel(this.state);
}
