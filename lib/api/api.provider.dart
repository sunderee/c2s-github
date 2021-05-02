import 'dart:convert';
import 'dart:io';

import 'package:c2sgithub/utils/exceptions/api.exception.dart';

class ApiProvider {
  final Uri baseURL;
  final HttpClient _client = HttpClient();

  ApiProvider(this.baseURL);

  Future<String> makeGraphQLRequest(String query, String authToken) async {
    final request = await _client.getUrl(baseURL)
      ..headers.contentType = ContentType.json
      ..headers.add(HttpHeaders.authorizationHeader, 'Bearer $authToken');
    final response = await request.close();

    if (response.statusCode == 200) {
      return await response
          .transform(Utf8Decoder(allowMalformed: true))
          .reduce((String previous, String element) => previous + element);
    }
    final rawBody = await response
        .transform(Utf8Decoder(allowMalformed: true))
        .reduce((String previous, String element) => previous + element);
    throw ApiException(
      response.statusCode,
      rawBody,
      'Query could not have been made',
    );
  }
}
