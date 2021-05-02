import 'dart:async';

import 'package:c2sgithub/api/repositories/profile.repository.dart';
import 'package:c2sgithub/api/repositories/repo.repository.dart';
import 'package:c2sgithub/redux/actions/api.action.dart';
import 'package:c2sgithub/redux/states/api.state.dart';
import 'package:c2sgithub/utils/helpers/cancellable_operation.dart';
import 'package:redux/redux.dart';

class ApiMiddleware implements MiddlewareClass<ApiState> {
  final ProfileRepository _profileRepository = ProfileRepository.instance();
  final RepoRepository _repoRepository = RepoRepository.instance();

  Timer? _timer;
  CancelableOperation<Store<ApiState>>? _operation;

  @override
  void call(Store<ApiState> store, dynamic action, NextDispatcher next) {
    action = action as ApiAction;
    if (action is LoadingApiAction) {
      store.dispatch(ApiAction.loading());
    } else if (action is ErrorApiAction) {
      store.dispatch(ApiAction.error(action.error));
    } else if (action is RetrieveHeadlineAction) {
      _timer?.cancel();
      _operation?.cancel();
      _timer = Timer(Duration(milliseconds: 100), () {
        store.dispatch(ApiAction.loading());
        _operation = CancelableOperation.fromFuture(
          _profileRepository
              .fetchProfile()
              .then((res) => store..dispatch(ApiAction.successful(res)))
              .catchError((e) => store..dispatch(ApiState.error(e.message))),
        );
      });
    } else if (action is RetrieveRepositoriesAction) {
      _timer?.cancel();
      _operation?.cancel();
      _timer = Timer(Duration(milliseconds: 25), () {
        _operation = CancelableOperation.fromFuture(_repoRepository
            .fetchRepositories(action.repositoryCount)
            .then((res) => store..dispatch(ApiAction.successful(res)))
            .catchError((e) => store..dispatch(ApiState.error(e.message))));
      });
    } else {
      store.dispatch(ApiAction.error('Unknown action: ${action.runtimeType}'));
    }

    next(action);
  }
}
