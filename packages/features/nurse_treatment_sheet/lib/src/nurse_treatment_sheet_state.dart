part of 'nurse_treatment_sheet_cubit.dart';

class NurseTreatmentSheetState extends Equatable {
  const NurseTreatmentSheetState({
    this.submissionStatus = SubmissionStatus.idle,
  });

  final SubmissionStatus submissionStatus;

  NurseTreatmentSheetState copyWith({
    SubmissionStatus? submissionStatus,
  }) {
    return NurseTreatmentSheetState(
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
    submissionStatus,
  ];
}

enum SubmissionStatus {
  idle,
  inProgress,
  success,
  genericError,
  //TODO: Add a specific error state for the nurse treatment feature
}