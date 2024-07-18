part of 'inpatient_list_cubit.dart';

/// The base class for all states in the Inpatient Cubit.
abstract class InpatientState extends Equatable {
  const InpatientState();

  @override
  List<Object?> get props => [];
}

/// The initial state when the Cubit is first created.
class InpatientInitial extends InpatientState {}

/// The state when the inpatient list is being loaded.
class InpatientLoading extends InpatientState {}

/// The state when the inpatient list has been successfully loaded.
class InpatientLoaded extends InpatientState {
  /// The list of inpatients.
  final List<Inpatient> inpatients;

  /// Indicates if the list has reached its maximum length (i.e., no more inpatients to load).
  final bool hasReachedMax;

  final Inpatient? selectedInpatient;

  const InpatientLoaded({
    required this.inpatients,
    this.selectedInpatient,
    required this.hasReachedMax,
  });

  /// Creates a copy of this state with the given values replaced.
  InpatientLoaded copyWith({
    List<Inpatient>? inpatients,
    bool? hasReachedMax,
    Inpatient? selectedInpatient,
  }) {
    return InpatientLoaded(
      inpatients: inpatients ?? this.inpatients,
      selectedInpatient: selectedInpatient ?? this.selectedInpatient,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [inpatients, hasReachedMax, selectedInpatient];
}

/// The state when a search for inpatients is being performed.
class InpatientSearching extends InpatientState {}

/// The state when the inpatient search results have been successfully loaded.
class InpatientSearchLoaded extends InpatientState {
  /// The list of inpatients returned by the search.
  final List<Inpatient> inpatients;

  const InpatientSearchLoaded({
    required this.inpatients,
  });

  @override
  List<Object?> get props => [inpatients];
}

/// The state when an error has occurred while loading or searching for inpatients.
class InpatientError extends InpatientState {
  /// The error message.
  final String message;

  const InpatientError(this.message);

  @override
  List<Object?> get props => [message];
}
