class NoUserTeamException implements Exception {
  String cause;
  NoUserTeamException(this.cause);
}