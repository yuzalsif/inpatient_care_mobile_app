import 'package:domain_models/domain_models.dart';
import 'package:inpatient_api/inpatient_api.dart';
import 'mappers/mappers.dart';


class IpdRepository {
  IpdRepository({
    required InpatientApi remoteApi,
  }) : _remoteApi = remoteApi;

  final InpatientApi _remoteApi;

  Future<void> createEncounter(Encounter encounter, String sessionId) async {
    final encounterRM = encounter.toRemote();
    await _remoteApi.createEncounter(encounterRM, sessionId);
  }
}