import 'encounter_provider.dart';
import 'ipd_form.dart';
import 'observation.dart';

class Encounter {
  final String patient;
  final String encounterType;
  final String location;
  final List<EncounterProvider> encounterProviders;
  final String visit;
  final List<Observation> observations;
  final IpdForm ipdForm;

  Encounter({
    required this.patient,
    required this.encounterType,
    required this.location,
    required this.encounterProviders,
    required this.visit,
    required this.observations,
    required this.ipdForm,
  });
}