import 'package:inpatient_api/src/models/request/user_credentials_rm.dart';

class SignInRequestRM {
  final UserCredentialsRM userCredentials;

  SignInRequestRM({
    required this.userCredentials,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userCredentials'] = userCredentials.toJson();
    return data;
  }
}