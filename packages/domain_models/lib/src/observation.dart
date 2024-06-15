class Observation {
  final String person;
  final String obsDateTime;
  final String concept;
  final String value;
  final String location;
  final String status;
  final String encounter;
  final bool voided;

  Observation({
    required this.person,
    required this.obsDateTime,
    required this.concept,
    required this.value,
    required this.location,
    required this.status,
    required this.encounter,
    required this.voided,
  });
}
