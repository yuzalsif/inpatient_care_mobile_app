import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'encounter_rm.g.dart';

@JsonSerializable(createFactory: false)
class EncounterRM {
  final String patient;
  final String encounterType;
  final String? location;
  @JsonKey(toJson: _encounterProvidersToJson)
  final List<EncounterProviderRM> encounterProviders;
  final String visit;
  @JsonKey(name: 'obs', toJson: _observationsToJson)
  final List<ObservationRM>? observations;
  @JsonKey(name: 'form', toJson: _ipdFormToJson)
  final IpdFormRM? ipdForm;
  @JsonKey(toJson: _ordersToJson)
  final List<OrderRM>? order;

  EncounterRM({
    required this.patient,
    required this.encounterType,
    this.location,
    required this.encounterProviders,
    required this.visit,
    this.observations,
    this.ipdForm,
    this.order,
  });

  static List<Map<String, dynamic>> _encounterProvidersToJson(
          List<EncounterProviderRM> encounterProviders) =>
      encounterProviders.map((provider) => provider.toJson()).toList();

  static List<Map<String, dynamic>> _observationsToJson(
      List<ObservationRM>? observations) {
    if (observations == null) {
      return [];
    } else {
      return observations.map((observation) => observation.toJson()).toList();
    }
  }

  static List<Map<String, dynamic>> _ordersToJson(List<OrderRM>? orders) {
    if (orders == null) {
      return [];
    } else {
      return orders.map((order) => order.toJson()).toList();
    }
  }

  static Map<String, dynamic> _ipdFormToJson(IpdFormRM? ipdForm) =>
      {if (ipdForm != null) "uuid": ipdForm.uuid else 'uuid': null};

  Map<String, dynamic> toJson() => _$EncounterRMToJson(this);
}
