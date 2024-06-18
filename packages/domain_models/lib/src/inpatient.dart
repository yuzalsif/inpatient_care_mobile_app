import 'package:equatable/equatable.dart';

class Inpatient extends Equatable {
 final String id;
  final String name;
  final int age;
  final String gender;
  final String address;
  final String phoneNumber;

  Inpatient({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.address,
    required this.phoneNumber,
  });
 
@override
List<Object?> get props => [
  id,
  name,
  age,
  gender,
  address,
  phoneNumber
];

}