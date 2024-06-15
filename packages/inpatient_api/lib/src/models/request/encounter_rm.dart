import 'package:inpatient_api/src/models/request/ipd_form_rm.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:inpatient_api/src/models/request/encounter_provider_rm.dart';
import 'package:inpatient_api/src/models/request/observation_rm.dart';

part 'encounter_rm.g.dart';

@JsonSerializable(createFactory: false)
class EncounterRM {
  final String patient;
  final String encounterType;
  final String location;
  @JsonKey(toJson: _encounterProvidersToJson)
  final List<EncounterProviderRM> encounterProviders;
  final String visit;
  @JsonKey(name: 'obs', toJson: _observationsToJson)
  final List<ObservationRM> observations;
  @JsonKey(name: 'form', toJson: _ipdFormToJson)
  final IpdFormRM ipdForm;

  EncounterRM({
    required this.patient,
    required this.encounterType,
    required this.location,
    required this.encounterProviders,
    required this.visit,
    required this.observations,
    required this.ipdForm,
  });

  static List<Map<String, dynamic>> _encounterProvidersToJson(List<EncounterProviderRM> encounterProviders) =>
      encounterProviders.map((provider) => provider.toJson()).toList();


  static List<Map<String, dynamic>> _observationsToJson(List<ObservationRM> observations) =>
      observations.map((observation) => observation.toJson()).toList();

  static Map<String, dynamic> _ipdFormToJson(IpdFormRM ipdForm) => ipdForm.toJson();

  Map<String, dynamic> toJson() => _$EncounterRMToJson(this);
}