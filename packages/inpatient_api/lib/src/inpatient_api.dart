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
          sessionId: authenticationToken,
          //TODO: Rename this field to authentication token
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

  Future<String> createEncounter(
      EncounterRM encounter, String sessionId) async {
    try {
      final url = _urlBuilder.buildEncounterUrl();
      var headersList = {
        "Accept": "*/*",
        "Access-Control-Allow-Origin": "*",
        "Authorization": "Basic $sessionId",
        'Content-Type': 'application/json'
      };
      var encounterUrl = Uri.parse(url);

      var request = http.Request('POST', encounterUrl);
      request.headers.addAll(headersList);

      final encounterJson = encounter.toJson();

      if (encounterJson['obs'] != null && encounterJson['obs'].isEmpty) {
        encounterJson.remove('obs');
      }
      if (encounterJson['order'] != null && encounterJson['order'].isEmpty) {
        encounterJson.remove('order');
      }

      if (encounterJson['form'] != null &&
          encounterJson['form']['uuid'] == null) {
        encounterJson.remove('form');
      }

      request.body = jsonEncode(encounterJson);
      print("**********ENCOUNTER BODY: ${request.body}");
      final res = await request.send();
      final resBody = await res.stream.bytesToString();

      print("***********STATUS CODE: ${res.statusCode}");
      if (res.statusCode >= 200 && res.statusCode < 300) {
        print("**************RESPONSE BODY $resBody");
      } else {
        print(
            "**************RESPONSE ERROR ${res.reasonPhrase} and $resBody} ************");
      }
      print("**************RESPONSE BODY $resBody");
      print('**********ENCOUNTER CREATED SUCCESSFULLY');
      final jsonBody = jsonDecode(resBody);
      return jsonBody['uuid'] as String;
    } catch (e) {
      print('**********FAILED to create ENCOUNTER ERROR: $e');
      throw 'Failed to create encounter: $e';
    }
  }

  Future<void> updateEncounter({
    required String authenticationToken,
    required String encounterUuid,
    required Map<String, dynamic> observations,
}) async {
    try {
      final url = _urlBuilder.buildEncounterUrl();
      var headersList = {
        "Accept": "*/*",
        "Access-Control-Allow-Origin": "*",
        "Authorization": "Basic $authenticationToken",
        'Content-Type': 'application/json'
      };
      var encounterUrl = Uri.parse('$url/$encounterUuid');

      var request = http.Request('POST', encounterUrl);
      request.headers.addAll(headersList);

      request.body = jsonEncode(observations);

      await request.send();
    } catch (e) {
      throw 'Failed to update encounter: $e';
    }
  }

  Future<String> getInpatientVisitId(
      String sessionId, String inpatientUuid) async {
    try {
      final url = _urlBuilder.buildGetInpatientVisitIdUrl(inpatientUuid);
      var headersList = {
        'Accept': "*/*",
        "Access-Control-Allow-Origin": "*",
        "Authorization": "Basic $sessionId"
      };
      var visitIdUrl = Uri.parse(url);

      var request = http.Request('GET', visitIdUrl);
      request.headers.addAll(headersList);

      var response = await request.send();
      final resBody = await response.stream.bytesToString();

      final responseData = jsonDecode(resBody);
      return responseData['results'][0]['uuid'] as String;
    } catch (e) {
      throw 'Failed to retrieve data: $e';
    }
  }

  Future<InpatientPageListRM> getInpatientListPage(
      int startIndex, String searchTerm) async {
    final url = Uri.parse(
        _urlBuilder.buildGetInpatientListPageUrl(startIndex, searchTerm));
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final inpatientPageList = InpatientPageListRM.fromJson(data);
      return inpatientPageList;
    } else {
      throw Exception('Failed to retrieve data: ${response.statusCode}');
    }
  }
}
