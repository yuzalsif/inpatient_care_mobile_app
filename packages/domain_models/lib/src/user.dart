class User {
  final String sessionId;
  final String username;
  final String userUuid;
  final String baseUrl;

  User(
      {required this.sessionId,
      required this.username,
      required this.userUuid,
      required this.baseUrl});
}
