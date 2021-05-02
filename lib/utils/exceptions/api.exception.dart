class ApiException implements Exception {
  final int statusCode;
  final String rawBody;
  final String message;

  const ApiException(this.statusCode, this.rawBody, this.message);
}
