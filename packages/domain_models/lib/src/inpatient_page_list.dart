import 'package:domain_models/src/inpatient.dart';
import 'package:equatable/equatable.dart';


class InpatientPageList extends Equatable {
  final List<Inpatient> inpatients;

  InpatientPageList({
    required this.inpatients,
  });

  @override
  List<Object?> get props => [
    inpatients
  ];
}
    


    