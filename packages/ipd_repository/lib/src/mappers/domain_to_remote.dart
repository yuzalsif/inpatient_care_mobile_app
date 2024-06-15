import 'package:domain_models/domain_models.dart';
import 'package:inpatient_api/inpatient_api.dart';

extension ObservationToRemote on Observation {
  ObservationRM toRemote() {
    return ObservationRM(
      person: person,
      obsDateTime: obsDateTime,
      concept: concept,
      value: value,
      location: location,
      status: status,
      encounter: encounter,
      voided: voided,
    );
  }
}

extension IpdFormToRemote on IpdForm {
  IpdFormRM toRemote() {
    return IpdFormRM(
      uuid: uuid,
    );
  }
}

extension EncounterProviderToRemote on EncounterProvider {
  EncounterProviderRM toRemote() {
    return EncounterProviderRM(
      provider: provider,
      encounterRole: encounterRole,
    );
  }
}

extension EncounterToRemote on Encounter {
  EncounterRM toRemote() {
    return EncounterRM(
      encounterType: encounterType,
      patient: patient,
      visit: visit,
      observations: observations.map((e) => e.toRemote()).toList(),
      encounterProviders: encounterProviders.map((e) => e.toRemote()).toList(),
      location: location,
      ipdForm: ipdForm.toRemote(),
    );
  }
}