class RequestEntity {
  final String id;
  final String name;
  final String amount;
  final DateTime dateTime;
  String status;

  RequestEntity({
    required this.id,
    required this.status,
    required this.name,
    required this.amount,
    required this.dateTime,
  });
}
