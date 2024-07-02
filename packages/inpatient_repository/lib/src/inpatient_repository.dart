import 'package:domain_models/domain_models.dart';
import 'package:inpatient_api/inpatient_api.dart';
import 'package:inpatient_repository/src/mappers/remote_to_domain.dart';
import 'package:rxdart/rxdart.dart';

//TODO: migrate to using inpatient_api instead of inpatient_api_temp

class InpatientRepository {
  InpatientRepository({required InpatientApiTemp remoteApi})
      : _remoteApi = remoteApi;

  final InpatientApiTemp _remoteApi;
  final BehaviorSubject<Inpatient?> _selectedInpatientSubject = BehaviorSubject();

  Future<InpatientPageList> getInpatientListPage(
      int startIndex, String searchTerm) async {
    final apiPage =
        await _remoteApi.getInpatientListPage(startIndex, searchTerm);

    final domainPage = apiPage.toDomainModel();

    return domainPage;
  }

  void selectInpatient(Inpatient inpatient) {
      _selectedInpatientSubject.add(inpatient);
  }

  Stream<Inpatient?> getSelectedInpatient() async* {
    if (!_selectedInpatientSubject.hasValue) {
      yield null;
    }
    yield* _selectedInpatientSubject.stream;
  }
}
