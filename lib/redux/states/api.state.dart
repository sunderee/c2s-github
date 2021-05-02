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
  factory ApiState.headline(
    Pair<HeadlineModel, int> data,
  ) = SuccessfulHeadlineState;
  factory ApiState.repositories(
    Pair<List<RepoModel>, int> data,
  ) = SuccessfulRepositoriesState;
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

class SuccessfulHeadlineState extends ApiState implements State {
  final Pair<HeadlineModel, int> _data;

  @override
  Object? get data => _data;

  @override
  String? get exception => null;

  @override
  bool get isLoading => false;

  const SuccessfulHeadlineState(this._data) : super._();
}

class SuccessfulRepositoriesState extends ApiState implements State {
  final Pair<List<RepoModel>, int> _data;

  @override
  Object? get data => _data;

  @override
  String? get exception => null;

  @override
  bool get isLoading => false;

  const SuccessfulRepositoriesState(this._data) : super._();
}
