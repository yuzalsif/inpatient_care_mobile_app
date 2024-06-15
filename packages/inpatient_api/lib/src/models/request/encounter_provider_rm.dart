import 'package:json_annotation/json_annotation.dart';

part 'encounter_provider_rm.g.dart';


@JsonSerializable(createFactory: false)
class EncounterProviderRM{
  final String encounter;
  final String encounterRole;

  EncounterProviderRM({
    required this.encounter,
    required this.encounterRole,
  });

  Map<String, dynamic> toJson() => _$EncounterProviderRMToJson(this);
}