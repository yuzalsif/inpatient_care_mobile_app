import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class Username extends FormzInput<String, UsernameValidationError>
    with EquatableMixin {
  const Username.unvalidated([
    String value = '',
  ])  : isWrongUsername = false,
        super.pure(value);

  const Username.validated(
      String value, {
        this.isWrongUsername = false,
      }) : super.dirty(value);


  final bool isWrongUsername;

  @override
  UsernameValidationError? validator(String value) {
    return value.isEmpty
        ? UsernameValidationError.empty
        : (isWrongUsername
        ? UsernameValidationError.wrongUsername : null);
  }

  @override
  List<Object?> get props => [
    value,
    isWrongUsername,
  ];
}

enum UsernameValidationError {
  empty,
  wrongUsername,
}
