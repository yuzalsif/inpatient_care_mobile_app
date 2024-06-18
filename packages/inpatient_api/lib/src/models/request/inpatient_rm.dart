// TODO: Migrate to json_serializable

class InpatientRM {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String address;
  final String phoneNumber;

  InpatientRM({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.address,
    required this.phoneNumber,
  });

  factory InpatientRM.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] as List<dynamic>? ?? [];
    final phoneNumberAttribute = attributes.firstWhere(
      (attr) => attr['display'] != null && attr['display'].contains(RegExp(r'^\d+$')),
      orElse: () => {'display': 'N/A'},
    );

    return InpatientRM(
      id: json['uuid'] ?? '',
      name: json['display'] ?? 'Unknown',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? 'Unknown',
      address: '', // Assuming address is not available in the provided JSON
      phoneNumber: phoneNumberAttribute['display'] as String,
    );
  }
}