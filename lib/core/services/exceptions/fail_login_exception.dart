class FailLoginException implements Exception {
  String cause;
  FailLoginException(this.cause);
}