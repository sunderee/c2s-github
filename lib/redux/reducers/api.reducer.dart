import 'package:c2sgithub/redux/actions/api.action.dart';
import 'package:c2sgithub/redux/states/api.state.dart';
import 'package:redux/redux.dart';

final apiReducer = combineReducers<ApiState>([
  TypedReducer<ApiState, LoadingApiAction>((_, __) => ApiState.loading()),
  TypedReducer<ApiState, SuccessfulApiAction>(
      (_, SuccessfulApiAction action) => ApiState.successful(action.data)),
  TypedReducer<ApiState, ErrorApiAction>(
      (_, ErrorApiAction action) => ApiState.error(action.error))
]);
