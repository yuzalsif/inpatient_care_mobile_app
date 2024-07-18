part of 'investigation_cubit.dart';

class InvestigationState extends Equatable {
  const InvestigationState({
    this.test = const InpatientTextField.unvalidated(),
    this.remarks = const InpatientTextField.unvalidated(),
    this.selectedTestResult = '',
    this.submissionStatus = SubmissionStatus.idle,
  });

  final InpatientTextField test;
  final InpatientTextField remarks;
  final String selectedTestResult;
  final SubmissionStatus submissionStatus;

  InvestigationState copyWith({
    InpatientTextField? test,
    InpatientTextField? remarks,
    String? selectedTestResult,
    SubmissionStatus? submissionStatus,
  }) {
    return InvestigationState(
      test: test ?? this.test,
      remarks: remarks ?? this.remarks,
      selectedTestResult: selectedTestResult ?? this.selectedTestResult,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
    test,
    remarks,
    selectedTestResult,
    submissionStatus,
  ];
}

enum SubmissionStatus {
  idle,
  inProgress,
  success,
  genericError,
  //TODO: Add a specific error state for the investigation feature
}