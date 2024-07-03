import 'package:domain_models/domain_models.dart';
import 'package:inpatient_api/inpatient_api.dart';
import 'mappers/mappers.dart';


class IpdRepository {
  IpdRepository({
    required InpatientApi remoteApi,
  }) : _remoteApi = remoteApi;

  final InpatientApi _remoteApi;

  static const String encounterRole = "240b26f9-dd88-4172-823d-4a8bfeb7841f";
  static const String provider = "63f4da67-1fd7-49e5-b517-cc98a2828127";
  static const encounterTypeIpd = "e22e39fd-7db2-45e7-80f1-60fa0d5a4378";
  static const locationIpd = "b1a8b05e-3542-4037-bbd3-998ee9c40574";
  static const conceptField1NurseTreatmentSheet = "14c61bde-dc18-4ab6-be9f-5b66a1d324cb";
  static const conceptField2NurseTreatmentSheet = "a7877534-4907-45b6-b020-7e4b8df08e69";
  static const formIDNurseTreatmentSheet = "6cbbe28d-884c-4c82-895d-8c7458c7d0a3";
  static const formIDObservationChart = "2a7d282f-a97a-4618-9515-9c0028d575d8";
  static const conceptWeightObservationChart = "5089AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
  static const conceptRespiratoryRateObservationChart = "5242AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
  static const conceptTemperatureObservationChart = "c37bd733-3f10-11e4-adec-0800271c1b75";
  static const conceptPulseObservationChart = "5087AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
  static const conceptDiastolicObservationChart = "c379aa1d-3f10-11e4-adec-0800271c1b75";
  static const conceptSystolicObservationChart = "c36e9c8b-3f10-11e4-adec-0800271c1b75";

  Future<void> createEncounter(Encounter encounter, String sessionId) async {
    final encounterRM = encounter.toRemote();
    await _remoteApi.createEncounter(encounterRM, sessionId);
  }

  Future<String> getInpatientVisitId (String sessionId, String inpatientUuid) async {
    return await _remoteApi.getInpatientVisitId(sessionId, inpatientUuid);
  }
}