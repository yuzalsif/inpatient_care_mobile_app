// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encounter_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$EncounterRMToJson(EncounterRM instance) =>
    <String, dynamic>{
      'patient': instance.patient,
      'encounterType': instance.encounterType,
      'location': instance.location,
      'encounterProviders':
          EncounterRM._encounterProvidersToJson(instance.encounterProviders),
      'visit': instance.visit,
      'obs': EncounterRM._observationsToJson(instance.observations),
      'form': EncounterRM._ipdFormToJson(instance.ipdForm),
      'orders': EncounterRM._ordersToJson(instance.orders),
    };
