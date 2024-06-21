import 'package:formz/formz.dart';

class InpatientTextField extends FormzInput<String, InpatientTextFieldValidationError> {
  const InpatientTextField.unvalidated([
    String value = '',
  ]) : super.pure(value);

  const InpatientTextField.validated([
    String value = '',
  ]) : super.dirty(value);

  @override
  InpatientTextFieldValidationError? validator(String value) {
    return isPure ? null : (value.isEmpty ? InpatientTextFieldValidationError.empty : null);
  }
}

enum InpatientTextFieldValidationError {
  empty,
}