// import 'package:patient/services/inpatient.dart';

// class InpatientListPageRM{
// InpatientListPageRM({required this.inpatients});

//   final List<InpatientRM> inpatients;

//   factory InpatientListPageRM.fromJson(Map<String, dynamic> json){
//     return InpatientListPageRM(
//       inpatients: (json['results'] as List<dynamic>)
//           .map((e) => InpatientRM.fromJson(e['patient']['person']))
//           .toList(),
//     );
//   }


// }


import 'package:inpatient_api/src/models/request/inpatient_rm.dart';

class InpatientPageListRM {
  final List<InpatientRM> inpatients;

  InpatientPageListRM({required this.inpatients});

  factory InpatientPageListRM.fromJson(Map<String, dynamic> json) {
    final results = json['results'] as List<dynamic>? ?? [];
    return InpatientPageListRM(
      inpatients: results
          .map((e) => InpatientRM.fromJson(e['patient']['person'] as Map<String, dynamic>? ?? {}))
          .toList(),
    );
  }
}