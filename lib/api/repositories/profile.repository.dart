import 'dart:convert';

import 'package:c2sgithub/api/api.provider.dart';
import 'package:c2sgithub/api/models/headline.model.dart';
import 'package:c2sgithub/utils/constants/config.dart';
import 'package:c2sgithub/utils/constants/graphql.const.dart';
import 'package:c2sgithub/utils/exceptions/api.exception.dart';
import 'package:c2sgithub/utils/exceptions/repository.exception.dart';
import 'package:c2sgithub/utils/helpers/format_query.helper.dart';
import 'package:c2sgithub/utils/tuple.dart';
import 'package:flutter/foundation.dart';

abstract class _IProfileRepository {
  Future<Pair<HeadlineModel, int>> fetchProfile();
}

class ProfileRepository implements _IProfileRepository {
  static final ProfileRepository _instance = ProfileRepository._();

  ProfileRepository._();
  factory ProfileRepository.instance() => _instance;

  @override
  Future<Pair<HeadlineModel, int>> fetchProfile() async {
    final result = await compute<Uri, Pair<HeadlineModel, int>?>(
      _parseFetchProfile,
      Uri.https('api.github.com', 'graphql'),
    );
    if (result != null) {
      return result;
    }
    throw RepositoryException('Could not have retrieved profile headline');
  }
}

Future<Pair<HeadlineModel, int>?> _parseFetchProfile(Uri uri) async {
  final provider = ApiProvider(uri);
  final authToken = GITHUB_TOKEN;
  try {
    final rawResult = await provider.makeGraphQLRequest(
      formatQuery(profileQuery),
      authToken,
    );
    final result = json.decode(rawResult) as Map<String, dynamic>;
    final headline = HeadlineModel.fromJson(result);
    return Pair(
      headline,
      result['data']['viewer']['repositories']['totalCount'] as int,
    );
  } on ApiException catch (e) {
    print(e.toString());
    return null;
  }
}
