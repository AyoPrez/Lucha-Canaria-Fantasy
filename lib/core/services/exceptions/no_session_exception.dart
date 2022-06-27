class NoSessionException implements Exception {
  String cause;
  NoSessionException(this.cause);
}