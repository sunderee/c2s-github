import 'package:c2sgithub/api/models/headline.model.dart';
import 'package:c2sgithub/api/models/repo.model.dart';
import 'package:c2sgithub/redux/actions/api.action.dart';
import 'package:c2sgithub/redux/states/api.state.dart';
import 'package:c2sgithub/utils/tuple.dart';
import 'package:redux/redux.dart';

final apiReducer = combineReducers<ApiState>([
  TypedReducer<ApiState, LoadingApiAction>((_, __) => ApiState.loading()),
  TypedReducer<ApiState, SuccessfulApiAction>((_, SuccessfulApiAction action) {
    if (action.data is Pair<HeadlineModel, int>) {
      return ApiState.headline(action.data);
    } else if (action.data is Pair<List<RepoModel>, int>) {
      return ApiState.repositories(action.data);
    } else {
      return ApiState.error('Unknown data type: ${action.data.runtimeType}');
    }
  }),
  TypedReducer<ApiState, ErrorApiAction>(
      (_, ErrorApiAction action) => ApiState.error(action.error))
]);
