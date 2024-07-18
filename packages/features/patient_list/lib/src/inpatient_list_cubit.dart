import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:inpatient_repository/inpatient_repository.dart';


part 'inpatient_list_state.dart';

class InpatientCubit extends Cubit<InpatientState> {
  final InpatientRepository _inpatientRepository;
  int currentPage = 0;
  Timer? _debounce;

  InpatientCubit(this._inpatientRepository) : super(InpatientLoading()) {
    fetchInpatients(); // Automatically fetch inpatients when the cubit is created
  }

  Future<void> fetchInpatients({String searchTerm = ''}) async {
    try {
      emit(InpatientLoading()); // Emit loading state
      currentPage = 0; // Reset the page count when fetching from scratch
      final inpatientListPage = await _inpatientRepository.getInpatientListPage(currentPage * 10, '');
      final List<Inpatient> inpatients = inpatientListPage.inpatients;
      currentPage += 1;
      if (inpatients.isEmpty) {
        emit(InpatientError('No patients found.'));
      } else {
        emit(InpatientLoaded(
          inpatients: inpatients,
          hasReachedMax: inpatients.length < 10,
        ));
      }
    } catch (e) {
      emit(InpatientError(e.toString()));
    }
  }

  Future<void> loadMoreInpatients() async {
    if (state is InpatientLoaded && !(state as InpatientLoaded).hasReachedMax) {
      try {
        final currentState = state as InpatientLoaded;
        final nextPage = await _inpatientRepository.getInpatientListPage(currentPage * 10, '');
        currentPage += 1;
        final newInpatients = nextPage.inpatients;

        emit(newInpatients.isEmpty
            ? currentState.copyWith(hasReachedMax: true)
            : InpatientLoaded(
                inpatients: currentState.inpatients + newInpatients,
                hasReachedMax: newInpatients.length < 10,
              ));
      } catch (e) {
        emit(InpatientError(e.toString()));
      }
    }
  }

  void selectInpatient(Inpatient inpatient) {
    _inpatientRepository.selectInpatient(inpatient);
    final newState = (state as InpatientLoaded).copyWith(selectedInpatient: inpatient);
    emit(newState);
  }

  void searchInpatients(String searchTerm) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      try {
        emit(InpatientSearching());
        final inpatientListPage = await _inpatientRepository.getInpatientListPage(0,  searchTerm);
        final List<Inpatient> inpatients = inpatientListPage.inpatients;
        emit(InpatientSearchLoaded(inpatients: inpatients ));
       
        if (inpatients.isEmpty) {
          emit(InpatientError('No patients found.'));
        } else {
          emit(InpatientSearchLoaded(inpatients: inpatients));
        }
      } catch (e) {
        emit(InpatientError(e.toString()));
      }
    });
  }
}
