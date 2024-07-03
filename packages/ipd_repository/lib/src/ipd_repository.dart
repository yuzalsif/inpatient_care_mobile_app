import 'dart:async';

import 'package:domain_models/domain_models.dart';
import 'package:inpatient_api/inpatient_api.dart';
import 'mappers/mappers.dart';

class IpdRepository {
  IpdRepository({
    required InpatientApi remoteApi,
  }) : _remoteApi = remoteApi;

  final InpatientApi _remoteApi;

  static const Map<String, String> labTest = {
    'AFB Staining': 'e146a962-710d-48bc-8298-a38527c78dc2',
    'ASOT (Anti Streptolysin O Test)': '88ddd459-1978-488d-ad12-f0a94fc6af85'
  };

  static const Map<String, String> prescription = {
    "Abacavir + Lamivudine Tablet 600mg + 300mg": "c91dec5a-0226-4e68-a110-440fd344ee1f"
  };

  static const String encounterRole = "240b26f9-dd88-4172-823d-4a8bfeb7841f";
  static const String provider = "63f4da67-1fd7-49e5-b517-cc98a2828127";
  static const encounterTypeIpd = "e22e39fd-7db2-45e7-80f1-60fa0d5a4378";
  static const encounterTypeClinic = "d7151f82-c1f3-4152-a605-2f9ea7414a79";
  static const orderTypeInvestigation = "52a447d3-a64a-11e3-9aeb-50e549534c5e";
  static const orderTypeManagement = "43c94345-c5e6-4f0b-9781-9803b226af72";
  static const locationIpd = "b1a8b05e-3542-4037-bbd3-998ee9c40574";
  static const locationClinic = "a4cf279b-23b5-48d8-9cc7-42c8a47c9d62";
  static const conceptField1NurseTreatmentSheet =
      "14c61bde-dc18-4ab6-be9f-5b66a1d324cb";
  static const conceptField2NurseTreatmentSheet =
      "a7877534-4907-45b6-b020-7e4b8df08e69";
  static const formIDNurseTreatmentSheet =
      "6cbbe28d-884c-4c82-895d-8c7458c7d0a3";
  static const formIDObservationChart = "2a7d282f-a97a-4618-9515-9c0028d575d8";
  static const conceptWeightObservationChart =
      "5089AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
  static const conceptRespiratoryRateObservationChart =
      "5242AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
  static const conceptTemperatureObservationChart =
      "c37bd733-3f10-11e4-adec-0800271c1b75";
  static const conceptPulseObservationChart =
      "5087AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
  static const conceptDiastolicObservationChart =
      "c379aa1d-3f10-11e4-adec-0800271c1b75";
  static const conceptSystolicObservationChart =
      "c36e9c8b-3f10-11e4-adec-0800271c1b75";
  static const conceptManagement = "ba8aa8b0-2112-426a-a2b4-f3215e6286f0";

  Future<String> createEncounter(Encounter encounter, String sessionId) async {
    final encounterRM = encounter.toRemote();
    return await _remoteApi.createEncounter(encounterRM, sessionId);
  }

  Future<String> getInpatientVisitId(
      String sessionId, String inpatientUuid) async {
    return await _remoteApi.getInpatientVisitId(sessionId, inpatientUuid);
  }

  Future<void> updateEncounter({
    required Map<String, dynamic> observations,
    required String authenticationToken,
    required String encounterUuid,
  }) async {
    await _remoteApi.updateEncounter(
      observations: observations,
      authenticationToken: authenticationToken,
      encounterUuid: encounterUuid,
    );
  }

  String toIso8601WithMillis(DateTime dateTime) {
    String y = dateTime.year.toString().padLeft(4, '0');
    String m = dateTime.month.toString().padLeft(2, '0');
    String d = dateTime.day.toString().padLeft(2, '0');
    String h = dateTime.hour.toString().padLeft(2, '0');
    String min = dateTime.minute.toString().padLeft(2, '0');
    String sec = dateTime.second.toString().padLeft(2, '0');
    String ms = (dateTime.millisecond / 1000).toStringAsFixed(3).substring(2);
    return "$y-$m-${d}T$h:$min:$sec.$ms" + "Z";
  }
}
