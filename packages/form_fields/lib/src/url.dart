import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class Url extends FormzInput<String, UrlValidationError>
    with EquatableMixin {
  const Url.unvalidated([
    String value = '',
  ])  : isUnknownAddress = false,
        super.pure(value);

  const Url.validated(
      String value, {
        this.isUnknownAddress = false,
      }) : super.dirty(value);

  static final _urlRegex = RegExp(
      r'^(https?:\/\/)?((([a-zA-Z0-9\-]+\.)+[a-zA-Z]{2,})|localhost)(:[0-9]{1,5})?(\/[^\s]*)?$',
  );

  final bool isUnknownAddress;

  @override
  UrlValidationError? validator(String value) {
    return value.isEmpty
        ? UrlValidationError.empty
        : (isUnknownAddress
        ? UrlValidationError.unKnownAddress
        : (_urlRegex.hasMatch(value)
        ? null
        : UrlValidationError.invalid));
  }

  @override
  List<Object?> get props => [
    value,
    isPure,
    isUnknownAddress,
  ];
}

enum UrlValidationError {
  empty,
  invalid,
  unKnownAddress,
}
