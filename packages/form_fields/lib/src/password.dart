import 'package:formz/formz.dart';

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.unvalidated([
    String value = '',
  ]) : super.pure(value);

  const Password.validated([
    String value = '',
  ]) : super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {
    return isPure ? null : (value.isEmpty ? PasswordValidationError.empty : null);
  }
}

enum PasswordValidationError {
  empty,
}
