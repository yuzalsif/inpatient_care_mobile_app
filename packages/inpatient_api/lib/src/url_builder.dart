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
        ' no base url was provided');
  }

  String buildSignInUrl() {
    // _checkForBaseUrlBeforeBuildAnyUrl();
    //TODO: Use [baseUrl] property instead of hard coded one
    return 'https://icare-student.dhis2.udsm.ac.tz/openmrs/ws/rest/v1/session?v=custom:(authenticated,user:(privileges:(uuid,name,roles),roles:(uuid,name)))';
  }

  String buildSignOutUrl() {
    // _checkForBaseUrlBeforeBuildAnyUrl();
    return 'https://icare-student.dhis2.udsm.ac.tz/openmrs/ws/rest/v1/session';
  }

  String buildEncounterUrl() {
    // _checkForBaseUrlBeforeBuildAnyUrl();
    return 'https://icare-student.dhis2.udsm.ac.tz/openmrs/ws/rest/v1/encounter';
  }

  String buildGetInpatientVisitIdUrl(String inpatientUuid) {
    // _checkForBaseUrlBeforeBuildAnyUrl();
    return 'https://icare-student.dhis2.udsm.ac.tz/openmrs/ws/rest/v1/visit?includeInactive=false&patient=$inpatientUuid&v=custom:(uuid)';
  }

String buildGetInpatientListPageUrl(
    int startIndex, 
    String searchTerm ,
  ) {
    //TODO: Use [baseUrl] property instead of hard coded one
    return 'https://icare-student.dhis2.udsm.ac.tz/openmrs/ws/rest/v1/icare/visit?OrderBy=ENCOUNTER&orderByDirection=ASC&q=$searchTerm&encounterTypeUuid=e22e39fd-7db2-45e7-80f1-60fa0d5a4378&startIndex=$startIndex&limit=10';
  }

}
