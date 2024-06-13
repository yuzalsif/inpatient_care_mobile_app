import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:form_fields/form_fields.dart';
import 'package:domain_models/domain_models.dart';
import 'package:user_repository/user_repository.dart';


part 'sign_in_state.dart';


class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required this.userRepository,
  }) : super(
    const SignInState(),
  );

  final UserRepository userRepository;

  void onUsernameChanged(String newValue) {
    final previousScreenState = state;
    final previousUsernameState = previousScreenState.username;
    final shouldValidate = previousUsernameState.isNotValid;
    final newUsernameState = shouldValidate
        ? Username.validated(
      newValue,
    )
        : Username.unvalidated(
      newValue,
    );

    final newScreenState = state.copyWith(
      username: newUsernameState,
    );

    emit(newScreenState);
  }

  void onUsernameUnfocused() {
    final previousScreenState = state;
    final previousUsernameState = previousScreenState.username;
    final previousUsernameValue = previousUsernameState.value;

    final newUsernameState = Username.validated(
      previousUsernameValue,
    );
    final newScreenState = previousScreenState.copyWith(
      username: newUsernameState,
    );
    emit(newScreenState);
  }

  void onPasswordChanged(String newValue) {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.password;
    final shouldValidate = previousPasswordState.isNotValid;
    final newPasswordState = shouldValidate
        ? Password.validated(
      newValue,
    )
        : Password.unvalidated(
      newValue,
    );

    final newScreenState = state.copyWith(
      password: newPasswordState,
    );

    emit(newScreenState);
  }

  void onPasswordUnfocused() {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.password;
    final previousPasswordValue = previousPasswordState.value;

    final newPasswordState = Password.validated(
      previousPasswordValue,
    );
    final newScreenState = previousScreenState.copyWith(
      password: newPasswordState,
    );
    emit(newScreenState);
  }

  void onUrlChanged(String newValue) {
    final previousScreenState = state;
    final previousUrlState = previousScreenState.baseUrl;
    final shouldValidate = previousUrlState.isNotValid;
    final newUrlState = shouldValidate
        ? Url.validated(
      newValue,
    )
        : Url.unvalidated(
      newValue,
    );

    final newScreenState = state.copyWith(
      baseUrl: newUrlState,
    );

    emit(newScreenState);
  }

  void onUrlUnfocused() {
    final previousScreenState = state;
    final previousUrlState = previousScreenState.baseUrl;
    final previousUrlValue = previousUrlState.value;

    final newUrlState = Url.validated(
      previousUrlValue,
    );
    final newScreenState = previousScreenState.copyWith(
      baseUrl: newUrlState,
    );
    emit(newScreenState);
  }

  void onSubmit() async {
    final username = Username.validated(state.username.value);
    final password = Password.validated(state.password.value);
    final url = Url.validated(state.baseUrl.value);

    final isFormValid = Formz.validate([
      username,
      password,
      url,
    ]);

    final newState = state.copyWith(
      username: username,
      password: password,
      baseUrl: url,
      submissionStatus: isFormValid ? SubmissionStatus.inProgress : null,
    );

    emit(newState);

    if (isFormValid) {
      try {
        await userRepository.signIn(
          baseUrl: url.value,
          username: username.value,
          password: password.value,
        );
        final newState = state.copyWith(
          submissionStatus: SubmissionStatus.success,
        );
        emit(newState);
      } catch (error) {
        final newState = state.copyWith(
          submissionStatus: error is InvalidCredentialsException
              ? SubmissionStatus.invalidCredentialsError
              : SubmissionStatus.genericError,
        );
        emit(newState);
      }
    }
  }
}
