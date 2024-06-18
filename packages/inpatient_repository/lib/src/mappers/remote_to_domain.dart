
import 'package:domain_models/domain_models.dart';
import 'package:inpatient_api/inpatient_api.dart';

extension InpatientRMtoDomain on InpatientRM {
  Inpatient toDomainModel() {
    return Inpatient(
        id: id,
        name: name,
        age: age,
        gender: gender,
        address: address,
        phoneNumber: phoneNumber,
        );
  }
}

extension InpatientPageListRMtoDomain on InpatientPageListRM {
  InpatientPageList toDomainModel() {
    return InpatientPageList(
        inpatients:
            inpatients.map((inpatient) => inpatient.toDomainModel()).toList());
  }
}
