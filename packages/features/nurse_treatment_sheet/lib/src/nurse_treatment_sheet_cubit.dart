import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:form_fields/form_fields.dart';
import 'package:equatable/equatable.dart';

part 'nurse_treatment_sheet_state.dart';

class InvestigationCubit extends Cubit<NurseTreatmentSheetState> {
  InvestigationCubit()
      : super(
    const NurseTreatmentSheetState(),
  );

  void onSubmit() {
    final oral = InpatientTextField.validated(state.oral.value);
    final injection = InpatientTextField.validated(state.injection.value);

    final isFormValid = oral.isValid || injection.isValid;

    final newState = state.copyWith(
      oral: oral,
      injection: injection,
      submissionStatus: isFormValid ? SubmissionStatus.inProgress : null,
    );

    emit(newState);

    if (isFormValid) {
      try {
        //TODO: Implement the submission logic
        final newState = state.copyWith(
          submissionStatus: SubmissionStatus.success,
        );
        emit(newState);
      } catch (error) {
        final newState = state.copyWith(
          //TODO: Add a specific error state for the investigation feature
          submissionStatus: SubmissionStatus.genericError,
        );
        emit(newState);
      }
    }
  }
}
