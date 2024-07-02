import '../domain_models.dart';

class Encounter {
  final String patient;
  final String encounterType;
  final String? location;
  final List<EncounterProvider> encounterProviders;
  final String visit;
  final List<Observation>? observations;
  final IpdForm? ipdForm;
  final List<Order>? order;

  Encounter({
    required this.patient,
    required this.encounterType,
    this.location,
    required this.encounterProviders,
    required this.visit,
    this.observations,
    this.order,
    this.ipdForm,
  });
}