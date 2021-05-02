import 'package:meta/meta.dart';

@sealed
abstract class ApiAction {
  const ApiAction._();

  factory ApiAction.loading() = LoadingApiAction;
  factory ApiAction.retrieveHeadlines() = RetrieveHeadlineAction;
  factory ApiAction.retrieveRepos(int count) = RetrieveRepositoriesAction;
  factory ApiAction.error(String error) = ErrorApiAction;
  factory ApiAction.successful(dynamic data) = SuccessfulApiAction;
}

class LoadingApiAction extends ApiAction {
  const LoadingApiAction() : super._();
}

class RetrieveHeadlineAction extends ApiAction {
  const RetrieveHeadlineAction() : super._();
}

class RetrieveRepositoriesAction extends ApiAction {
  final int repositoryCount;

  const RetrieveRepositoriesAction(this.repositoryCount) : super._();
}

class ErrorApiAction extends ApiAction {
  final String error;

  const ErrorApiAction(this.error) : super._();
}

class SuccessfulApiAction<T> extends ApiAction {
  final T data;

  const SuccessfulApiAction(this.data) : super._();
}
