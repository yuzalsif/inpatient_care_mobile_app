part of 'nurse_treatment_sheet_cubit.dart';

class NurseTreatmentSheetState extends Equatable {
  const NurseTreatmentSheetState({
    this.oral = const InpatientTextField.unvalidated(),
    this.injection = const InpatientTextField.unvalidated(),
    this.selectedOralResult = '',
    this.selectedInjectionResult = '',
    this.submissionStatus = SubmissionStatus.idle,
  });

  final InpatientTextField oral;
  final InpatientTextField injection;
  final String selectedOralResult;
  final String selectedInjectionResult;
  final SubmissionStatus submissionStatus;

  NurseTreatmentSheetState copyWith({
    InpatientTextField? oral,
    InpatientTextField? injection,
    String? selectedOralResult,
    String? selectedInjectionResult,
    SubmissionStatus? submissionStatus,
  }) {
    return NurseTreatmentSheetState(
      oral: oral ?? this.oral,
      injection: injection ?? this.injection,
      selectedOralResult: selectedOralResult ?? this.selectedOralResult,
      selectedInjectionResult: selectedInjectionResult ?? this.selectedInjectionResult,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
    oral,
    injection,
    selectedOralResult,
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