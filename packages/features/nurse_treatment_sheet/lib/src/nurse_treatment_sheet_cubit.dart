import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:ipd_repository/ipd_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:domain_models/domain_models.dart';

part 'nurse_treatment_sheet_state.dart';

class NurseTreatmentSheetCubit extends Cubit<NurseTreatmentSheetState> {
  final IpdRepository ipdRepository;
  final UserRepository userRepository;
  final Inpatient selectedInpatient;

  final TextEditingController oralMedicationController;
  final TextEditingController oralInfusionController;

  NurseTreatmentSheetCubit({
    required this.ipdRepository,
    required this.userRepository,
    required this.selectedInpatient,
    required this.oralMedicationController,
    required this.oralInfusionController,
  }) : super(
          const NurseTreatmentSheetState(),
        );

  void onSubmit() async {
    emit(state.copyWith(submissionStatus: SubmissionStatus.inProgress));
    try {
      final submissionTime = ipdRepository.toIso8601WithMillis(DateTime.now());
      List<Observation> observations = [];
      oralMedicationController.text != ''
          ? observations.add(Observation(
              person: selectedInpatient.id,
              obsDatetime: submissionTime,
              concept: IpdRepository.conceptField1NurseTreatmentSheet,
              value: oralMedicationController.text,
              location: IpdRepository.locationIpd,
              status: "PRELIMINARY",
              voided: false))
          : null;

      oralInfusionController.text != ''
          ? observations.add(Observation(
              person: selectedInpatient.id,
              obsDatetime: submissionTime,
              concept: IpdRepository.conceptField2NurseTreatmentSheet,
              value: oralInfusionController.text,
              location: IpdRepository.locationIpd,
              status: "PRELIMINARY",
              voided: false))
          : null;

      final encounterProviders = [
        EncounterProvider(
            provider: IpdRepository.provider,
            encounterRole: IpdRepository.encounterRole)
      ];

      final ipdForm = IpdForm(uuid: IpdRepository.formIDNurseTreatmentSheet);

      final currentUserSessionId = await userRepository.getUserSessionId();
      print("*********SESSEION ID: $currentUserSessionId");
      print("*********INPATIENT ID: ${selectedInpatient.id}");
      final selectedInpatientVisitId = await ipdRepository.getInpatientVisitId(
          currentUserSessionId ?? '', selectedInpatient.id);
      print("**********VISIT ID: $selectedInpatientVisitId");
      final encounter = Encounter(
        patient: selectedInpatient.id,
        encounterType: IpdRepository.encounterTypeIpd,
        encounterProviders: encounterProviders,
        visit: selectedInpatientVisitId,
        observations: observations,
        ipdForm: ipdForm,
        location: IpdRepository.locationIpd,
      );

      await ipdRepository.createEncounter(
          encounter, currentUserSessionId ?? '');
      emit(state.copyWith(submissionStatus: SubmissionStatus.success));
    } catch (e) {
      print("****************ERRORRRR: ${e.toString()}");
      emit(state.copyWith(submissionStatus: SubmissionStatus.genericError));
    }
  }
}
