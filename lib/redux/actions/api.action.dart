import 'package:c2sgithub/api/models/headline.model.dart';
import 'package:c2sgithub/api/models/repo.model.dart';
import 'package:c2sgithub/utils/tuple.dart';
import 'package:meta/meta.dart';

@sealed
abstract class ApiAction {
  const ApiAction._();

  factory ApiAction.loading() = LoadingApiAction;
  factory ApiAction.error(String error) = ErrorApiAction;
  factory ApiAction.retrieveProfile() = RetrieveProfileAction;
  factory ApiAction.successful(
    Triple<HeadlineModel, List<RepoModel>, int> data,
  ) = SuccessfulApiAction;
}

class LoadingApiAction extends ApiAction {
  const LoadingApiAction() : super._();
}

class RetrieveProfileAction extends ApiAction {
  const RetrieveProfileAction() : super._();
}

class ErrorApiAction extends ApiAction {
  final String error;

  const ErrorApiAction(this.error) : super._();
}

class SuccessfulApiAction extends ApiAction {
  final Triple<HeadlineModel, List<RepoModel>, int> data;

  const SuccessfulApiAction(this.data) : super._();
}
