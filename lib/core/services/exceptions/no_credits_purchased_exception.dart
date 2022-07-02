class NoCreditsPurchasedException implements Exception {
  String cause;
  NoCreditsPurchasedException(this.cause);
}