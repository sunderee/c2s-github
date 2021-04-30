import 'dart:convert';
import 'dart:io';

class ApiProvider {
  final Uri baseURL;
  final HttpClient _client = HttpClient();

  ApiProvider(this.baseURL);

  Future<String?> makeGraphQLRequest(String query, String authToken) async {
    final request = await _client.getUrl(baseURL)
      ..headers.contentType = ContentType.json
      ..headers.add(HttpHeaders.authorizationHeader, 'Bearer $authToken');
    final response = await request.close();

    if (response.statusCode == 200) {
      var rawResponse = '';
      await response
          .transform(Utf8Decoder(allowMalformed: true))
          .forEach((element) => rawResponse += element);
      return rawResponse;
    }
    return null;
  }
}
