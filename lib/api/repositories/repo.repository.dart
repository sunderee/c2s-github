import 'dart:convert';

import 'package:c2sgithub/api/api.provider.dart';
import 'package:c2sgithub/api/models/repo.model.dart';
import 'package:c2sgithub/utils/constants/graphql.const.dart';
import 'package:c2sgithub/utils/exceptions/api.exception.dart';
import 'package:c2sgithub/utils/exceptions/repository.exception.dart';
import 'package:c2sgithub/utils/helpers/config.helper.dart';
import 'package:c2sgithub/utils/helpers/format_query.helper.dart';
import 'package:c2sgithub/utils/tuple.dart';
import 'package:flutter/foundation.dart';

abstract class _IRepoRepository {
  Future<Pair<List<RepoModel>, int>> fetchRepositories(int count);
}

class RepoRepository implements _IRepoRepository {
  static final RepoRepository _instance = RepoRepository._();

  RepoRepository._();
  factory RepoRepository.instance() => _instance;

  @override
  Future<Pair<List<RepoModel>, int>> fetchRepositories(int count) async {
    final result = await compute<Pair<Uri, int>, Pair<List<RepoModel>, int>?>(
      _parseFetchRepositories,
      Pair(Uri.https('api.github.com', 'graphql'), count),
    );
    if (result != null) {
      return result;
    }
    throw RepositoryException('Could not have retrieve user repositories');
  }
}

Future<Pair<List<RepoModel>, int>?> _parseFetchRepositories(
  Pair<Uri, int> data,
) async {
  final provider = ApiProvider(data.first);
  final authToken = await loadToken();
  if (authToken != null) {
    try {
      final rawResult = await provider.makeGraphQLRequest(
        formatQuery(repositoriesQuery(data.second)),
        authToken,
      );
      final result = json.decode(rawResult) as Map<String, dynamic>;
      final raw_repositories =
          (result['data']['viewer']['repositories']['nodes'] as List<dynamic>)
              .cast<Map<String, dynamic>>();
      final stars = raw_repositories
          .map((element) => element['stargazerCount'] as int)
          .reduce((value, element) => value + element);
      final repositories = raw_repositories
          .where((element) => element['isPrivate'])
          .map((element) => RepoModel.fromJson(element))
          .toList();
      return Pair(repositories, stars);
    } on ApiException {
      return null;
    }
  }
  return null;
}
