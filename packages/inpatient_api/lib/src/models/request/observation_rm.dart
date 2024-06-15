import 'package:json_annotation/json_annotation.dart';

part 'observation_rm.g.dart';

@JsonSerializable(createFactory: false)
class ObservationRM {
  final String person;
  final String obsDateTime;
  final String concept;
  final String value;
  final String location;
  final String status;
  final String encounter;
  final bool voided;

  ObservationRM({
    required this.person,
    required this.obsDateTime,
    required this.concept,
    required this.value,
    required this.location,
    required this.status,
    required this.encounter,
    required this.voided,
  });

  Map<String, dynamic> toJson() => _$ObservationRMToJson(this);
}