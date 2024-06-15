import 'package:json_annotation/json_annotation.dart';

part 'ipd_form_rm.g.dart';

@JsonSerializable(createFactory: false)
class IpdFormRM {
  final String uuid;

  IpdFormRM({
    required this.uuid,
  });

  Map<String, dynamic> toJson() => _$IpdFormRMToJson(this);
}
