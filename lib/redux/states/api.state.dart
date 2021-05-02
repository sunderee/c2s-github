import 'package:c2sgithub/api/models/headline.model.dart';
import 'package:c2sgithub/api/models/repo.model.dart';
import 'package:c2sgithub/redux/state.redux.dart';
import 'package:c2sgithub/utils/tuple.dart';
import 'package:meta/meta.dart';

@sealed
abstract class ApiState {
  const ApiState._();

  factory ApiState.loading() = LoadingApiState;
  factory ApiState.error(String error) = ErrorApiState;
  factory ApiState.successful(
    Triple<HeadlineModel, List<RepoModel>, int> data,
  ) = SuccessfulApiState;
}

class LoadingApiState extends ApiState implements State {
  @override
  Object? get data => null;

  @override
  String? get exception => null;

  @override
  bool get isLoading => true;

  const LoadingApiState() : super._();
}

class ErrorApiState extends ApiState implements State {
  final String _error;

  @override
  Object? get data => null;

  @override
  String? get exception => _error;

  @override
  bool get isLoading => false;

  const ErrorApiState(this._error) : super._();
}

class SuccessfulApiState extends ApiState implements State {
  final Triple<HeadlineModel, List<RepoModel>, int> _data;

  @override
  Object? get data => _data;

  @override
  String? get exception => null;

  @override
  bool get isLoading => false;

  const SuccessfulApiState(this._data) : super._();
}
