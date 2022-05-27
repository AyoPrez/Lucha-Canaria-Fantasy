class FailRegisterException implements Exception {
  String cause;
  FailRegisterException(this.cause);
}