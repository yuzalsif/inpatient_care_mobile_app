import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inpatient_api/inpatient_api.dart';

//import 'package:inpatient_api/src/models/request/inpatient_list_page_rm.dart';

//import 'url_builder.dart';

class InpatientApiTemp {
  final UrlBuilderTemp _urlBuilder;

  InpatientApiTemp({required UrlBuilderTemp urlBuilder}) : _urlBuilder = urlBuilder;

  Future<InpatientPageListRM> getInpatientListPage(int startIndex, String searchTerm  ) async {
    final url = Uri.parse(_urlBuilder.buildGetInpatientListPageUrl(startIndex, searchTerm));
    print('Request URL: $url'); // Debug statement
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Response data: $data'); // Debug statement
      final inpatientPageList = InpatientPageListRM.fromJson(data);
      return inpatientPageList;
    } else {
      throw Exception('Failed to retrieve data: ${response.statusCode}');
    }
  }
}
