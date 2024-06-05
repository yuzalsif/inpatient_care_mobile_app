import 'base_url_storage.dart';

class UrlBuilder {
  final String _baseUrl;

  UrlBuilder._(this._baseUrl);

  static Future<UrlBuilder> create() async {
    final String baseUrl = await BaseUrlStorage.baseUrl;
    return UrlBuilder._(baseUrl);
  }

  String buildSignInUrl() {
    return '$_baseUrl/openmrs/ws/rest/v1/session?v=custom:(authenticated,user:(privileges:(uuid,name,roles),roles:(uuid,name)))';
  }
}
