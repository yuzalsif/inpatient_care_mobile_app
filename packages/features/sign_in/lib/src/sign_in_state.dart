part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  const SignInState({
    this.username = const Username.unvalidated(),
    this.password = const Password.unvalidated(),
    this.baseUrl = const Url.unvalidated(),
    this.submissionStatus = SubmissionStatus.idle,
  });

  final Username username;
  final Password password;
  final Url baseUrl;
  final SubmissionStatus submissionStatus;

  SignInState copyWith({
    Username? username,
    Password? password,
    Url? baseUrl,
    SubmissionStatus? submissionStatus,
  }) {
    return SignInState(
      username: username ?? this.username,
      password: password ?? this.password,
      baseUrl: baseUrl ?? this.baseUrl,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
    username,
    password,
    baseUrl,
    submissionStatus,
  ];
}

enum SubmissionStatus {
  /// Used when the form has not been sent yet.
  idle,

  /// Used to disable all buttons and add a progress indicator to the main one.
  inProgress,

  /// Used to close the screen and navigate back to the caller screen.
  success,
  /// Used to display a generic snack bar saying that an error has occurred, e.g., no internet connection.
  genericError,

  /// Used to show a more specific error telling the user they got the email and/or password wrong.
  invalidCredentialsError,
}
