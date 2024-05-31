class UserCredentialsRM {
  String username;
  String password;
  String url;

  UserCredentialsRM({
    required this.username,
    required this.password,
    required this.url,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['url'] = url;
    return data;
  }
}