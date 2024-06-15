import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/models.dart';
import 'base_url_storage.dart';
import 'models/exceptions.dart';
import 'url_builder.dart';

class InpatientApi {
  late UrlBuilder _urlBuilder;

  InpatientApi() {
    _initUrlBuilder();
  }

  _initUrlBuilder() async {
    _urlBuilder = await UrlBuilder.create();
  }

  Future<UserRM> signIn({
    required String username,
    required String password,
    required String baseUrl,
  }) async {
    var signInUrl = '';
    final signInRequest = SignInRequestRM(
        userCredentials: UserCredentialsRM(
      username: username,
      password: password,
      url: baseUrl,
    ));

    var bytes = utf8.encode(
        '${signInRequest.userCredentials.username}:${signInRequest.userCredentials.password}');
    var authenticationToken = base64.encode(bytes);
    var headersList = {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Authorization": "Basic $authenticationToken"
    };

    final String cachedBaseUrl = await BaseUrlStorage.baseUrl;

    if (cachedBaseUrl == BaseUrlStorage.noCachedBaseUrl ||
        cachedBaseUrl != signInRequest.userCredentials.url) {
      BaseUrlStorage.setBaseUrl(signInRequest.userCredentials.url);
      _urlBuilder = await UrlBuilder.create();
    }

    signInUrl = _urlBuilder.buildSignInUrl();

    var request = http.Request('GET', Uri.parse(signInUrl));
    request.headers.addAll(headersList);

    var response = await request.send();
    final resBody = await response.stream.bytesToString();

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print(resBody);
      final Map<String, dynamic> responseData = jsonDecode(resBody);
      return UserRM(
          sessionId: responseData['sessionId'] as String,
          username: responseData['user']['username'] as String,
          userUuid: responseData['user']['uuid'] as String,
          baseUrl: _urlBuilder.baseUrl);
    } else {
      throw InvalidCredentialsInpatientException();
    }
  }

  Future<void> signOut() async {
    final url = _urlBuilder.buildSignOutUrl();

    Map<String, String> headersList = {};
    var logOutUrl = Uri.parse(url);

    var request = http.Request('DELETE', logOutUrl);
    request.headers.addAll(headersList);

    await request.send();
  }

  Future<void> createEncounter(EncounterRM encounter, String sessionId) async {
    final url = _urlBuilder.buildEncounterUrl();
    var headersList = {
      'Accept': 'application/json, text/plain, */*',
      'JSESSIONID': sessionId,
      'Content-Type': 'application/json'
    };
    var encounterUrl = Uri.parse(url);

    var request = http.Request('POST', encounterUrl);
    request.headers.addAll(headersList);
    request.body = jsonEncode(encounter.toJson());

    await request.send();
  }
}
