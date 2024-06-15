import 'package:json_annotation/json_annotation.dart';

part 'encounter_provider_rm.g.dart';


@JsonSerializable(createFactory: false)
class EncounterProviderRM{
  final String provider;
  final String encounterRole;

  EncounterProviderRM({
    required this.provider,
    required this.encounterRole,
  });

  Map<String, dynamic> toJson() => _$EncounterProviderRMToJson(this);
}