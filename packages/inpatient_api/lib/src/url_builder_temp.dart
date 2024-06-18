class UrlBuilderTemp {
  const UrlBuilderTemp({String? baseUrl})
      : _baseUrl = baseUrl ?? 'https://icare-student.dhis2.udsm.ac.tz/openmrs/ws/rest/v1/icare/visit';

  final String _baseUrl;

  String buildGetInpatientListPageUrl(
    int startIndex, 
    String searchTerm ,
  ) {
    return '$_baseUrl?OrderBy=ENCOUNTER&orderByDirection=ASC&q=$searchTerm&encounterTypeUuid=e22e39fd-7db2-45e7-80f1-60fa0d5a4378&startIndex=$startIndex&limit=10';
  }
}

