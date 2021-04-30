import 'dart:convert';

import 'package:c2sgithub/api/api.provider.dart';
import 'package:c2sgithub/api/models/headline.model.dart';
import 'package:c2sgithub/utils/constants/graphql.const.dart';
import 'package:c2sgithub/utils/helpers/config.helper.dart';
import 'package:c2sgithub/utils/helpers/format_query.helper.dart';
import 'package:c2sgithub/utils/tuple.dart';
import 'package:flutter/foundation.dart';

abstract class _IProfileRepository {
  Future<Pair<HeadlineModel, int>?> fetchProfile();
}

class ProfileRepository implements _IProfileRepository {
  static final ProfileRepository _instance = ProfileRepository._();

  ProfileRepository._();
  factory ProfileRepository.instance() => _instance;

  @override
  Future<Pair<HeadlineModel, int>?> fetchProfile() async =>
      compute<Uri, Pair<HeadlineModel, int>?>(
        _parseFetchProfile,
        Uri.https('api.github.com', 'graphql'),
      );
}

Future<Pair<HeadlineModel, int>?> _parseFetchProfile(Uri uri) async {
  final provider = ApiProvider(uri);
  final authToken = await loadToken();
  if (authToken != null) {
    final raw_result = await provider.makeGraphQLRequest(
      formatQuery(PROFILE_QUERY),
      authToken,
    );
    if (raw_result != null) {
      final result = json.decode(raw_result) as Map<String, dynamic>;
      final headline = HeadlineModel.fromJson(result);
      return Pair(
        headline,
        result['data']['viewer']['repositories']['totalCount'] as int,
      );
    }
    return null;
  }
  return null;
}
