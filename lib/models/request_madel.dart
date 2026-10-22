class RequestModel {
  final String id;
  final String name;
  final String amount;
  final DateTime dateTime;
  String status;

  RequestModel({
    required this.id,
    required this.status,
    required this.name,
    required this.amount,
    required this.dateTime,
  });
}