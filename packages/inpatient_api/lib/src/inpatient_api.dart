import 'dart:convert';

import 'models/models.dart';

class InpantientApi {
  Future<UserRM> signIn ({required String username,required String password, required String url}) {
    final signInRequest = SignInRequestRM(userCredentials: UserCredentialsRM(username: username, password: password, url: url));
    var bytes = utf8.encode('${signInRequest.userCredentials.username}:${signInRequest.userCredentials.password}');
    var authenticationToken = base64.encode(bytes);
    var headersList = {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Authorization": "Basic $authenticationToken"
    };
    
    var url = Uri.parse('https://icare-student.dhis2.udsm.ac.tz/openmrs/ws/rest/v1/session?v=custom%3A(authenticated%2Cuser%3A(privileges%3A(uuid%2Cname%2Croles)%2Croles%3A(uuid%2Cname)))');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    }
    else {
      print(res.reasonPhrase);
    }
  }
}