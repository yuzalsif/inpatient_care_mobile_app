class Observation {
  final String person;
  final String obsDatetime;
  final String concept;
  final String value;
  final String location;
  final String status;
  String? encounter;
  final bool voided;

  Observation({
    required this.person,
    required this.obsDatetime,
    required this.concept,
    required this.value,
    required this.location,
    required this.status,
    this.encounter,
    required this.voided,
  });
}
