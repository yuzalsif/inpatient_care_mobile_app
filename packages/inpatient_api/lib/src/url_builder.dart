import 'base_url_storage.dart';

class UrlBuilder {
  final String _baseUrl;

  static const String _noBaseUrl = 'NO BASE URL AVAILABLE';

  UrlBuilder._(this._baseUrl);

  static Future<UrlBuilder> create() async {
    final String baseUrl = await BaseUrlStorage.baseUrl;
    return (baseUrl == BaseUrlStorage.noCachedBaseUrl)
        ? UrlBuilder._(_noBaseUrl)
        : UrlBuilder._(baseUrl);
  }

  void _checkForBaseUrlBeforeBuildAnyUrl() {
    assert(
        (_noBaseUrl == _baseUrl),
        'Consider sign-in user first to get the base url'
        'no base url was provided');
  }

  String buildSignInUrl() {
    _checkForBaseUrlBeforeBuildAnyUrl();
    return '$_baseUrl/openmrs/ws/rest/v1/session?v=custom:(authenticated,user:(privileges:(uuid,name,roles),roles:(uuid,name)))';
  }
}
