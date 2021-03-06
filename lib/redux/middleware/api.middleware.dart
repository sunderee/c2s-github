import 'package:c2sgithub/api/repositories/profile.repository.dart';
import 'package:c2sgithub/api/repositories/repo.repository.dart';
import 'package:c2sgithub/redux/actions/api.action.dart';
import 'package:c2sgithub/redux/states/api.state.dart';
import 'package:c2sgithub/utils/tuple.dart';
import 'package:redux/redux.dart';

class ApiMiddleware implements MiddlewareClass<ApiState> {
  final ProfileRepository _profileRepository = ProfileRepository.instance();
  final RepoRepository _repoRepository = RepoRepository.instance();

  @override
  void call(Store<ApiState> store, dynamic action, NextDispatcher next) {
    if (action is RetrieveProfileAction) {
      _profileRepository
          .fetchProfile()
          .then((result) => _repoRepository
              .fetchRepositories(result.second)
              .then((innerResult) => store
                ..dispatch(ApiAction.successful(Triple(
                  result.first,
                  innerResult.first,
                  innerResult.second,
                ))))
              .catchError((error) => store
                ..dispatch(ApiAction.error(
                  error.message,
                ))))
          .catchError((error) => store
            ..dispatch(ApiAction.error(
              error.message,
            )));
    }
    next(action);
  }
}
