class NoUserException implements Exception {
  String cause;
  NoUserException(this.cause);
}