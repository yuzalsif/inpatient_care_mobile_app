import 'base_url_storage.dart';

class UrlBuilder {
  final String baseUrl;

  static const String _noBaseUrl = 'NO BASE URL AVAILABLE';

  UrlBuilder._(this.baseUrl);

  static Future<UrlBuilder> create() async {
    final String baseUrl = await BaseUrlStorage.baseUrl;
    return (baseUrl == BaseUrlStorage.noCachedBaseUrl)
        ? UrlBuilder._(_noBaseUrl)
        : UrlBuilder._(baseUrl);
  }

  void _checkForBaseUrlBeforeBuildAnyUrl() {
    assert(
        (_noBaseUrl == baseUrl),
        'Consider sign-in user first to get the base url'
        'no base url was provided');
  }

  String buildSignInUrl() {
    _checkForBaseUrlBeforeBuildAnyUrl();
    return '$baseUrl/openmrs/ws/rest/v1/session?v=custom:(authenticated,user:(privileges:(uuid,name,roles),roles:(uuid,name)))';
  }

  String buildSignOutUrl() {
    _checkForBaseUrlBeforeBuildAnyUrl();
    return '$baseUrl/openmrs/ws/rest/v1/session';
  }
}
