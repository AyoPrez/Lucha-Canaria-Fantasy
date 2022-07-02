class ErrorDuringCreditsPurchasedException implements Exception {
  String cause;
  ErrorDuringCreditsPurchasedException(this.cause);
}