import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:equatable/equatable.dart';

part 'investigation_state.dart';

class InvestigationCubit extends Cubit<InvestigationState> {
  InvestigationCubit()
      : super(
          const InvestigationState(),
        );

  void onSubmit() {
    final test = InpatientTextField.validated(state.test.value);
    final remarks = InpatientTextField.validated(state.remarks.value);

    final isFormValid = test.isValid || remarks.isValid;

    final newState = state.copyWith(
      test: test,
      remarks: remarks,
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
