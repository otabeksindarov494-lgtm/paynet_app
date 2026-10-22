import 'package:paynet_app/domain/entities/request_entity.dart';

class RequestModel extends RequestEntity {
  RequestModel({
    required String id,
    required String status,
    required String name,
    required String amount,
    required DateTime dateTime,
  }) : super(
          id: id,
          status: status,
          name: name,
          amount: amount,
          dateTime: dateTime,
        );

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      status: json['status'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'status': status,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory RequestModel.fromEntity(RequestEntity entity) {
    return RequestModel(
      id: entity.id,
      status: entity.status,
      name: entity.name,
      amount: entity.amount,
      dateTime: entity.dateTime,
    );
  }
}
