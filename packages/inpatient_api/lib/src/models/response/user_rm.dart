class UserRM {
  String sessionId;
  String username;
  String userUid;

  UserRM({
    required this.sessionId,
    required this.username,
    required this.userUid,
  });

  factory UserRM.fromJson(Map<String, dynamic> json) {
    return UserRM(
      sessionId: json['sessionId'] as String,
      username: json['user']['username'] as String,
      userUid: json['user']['uuid'] as String,
    );
  }
}