import 'package:formz/formz.dart';

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.unvalidated([
    String value = '',
  ]) : super.pure(value);

  const Username.validated([
    String value = '',
  ]) : super.dirty(value);

  @override
  UsernameValidationError? validator(String value) {
    return value.isEmpty ? UsernameValidationError.empty : null;
  }
}

enum UsernameValidationError {
  empty,
}
