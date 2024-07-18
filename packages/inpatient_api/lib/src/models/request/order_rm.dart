import 'package:json_annotation/json_annotation.dart';

part 'order_rm.g.dart';


@JsonSerializable(createFactory: false)
class OrderRM {
  final String? concept;
  final String? orderType;
  final String? action;
  final String? patient;
  final String? careSetting;
  final String? orderer;
  final String? urgency;
  final String? instructions;
  final String? type;

  OrderRM({
    this.concept,
    this.orderType,
    this.action,
    this.patient,
    this.careSetting,
    this.orderer,
    this.urgency,
    this.instructions,
    this.type,
  });

  Map<String, dynamic> toJson() => _$OrderRMToJson(this);
}