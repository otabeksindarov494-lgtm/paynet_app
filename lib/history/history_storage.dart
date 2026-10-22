import 'dart:convert';

import 'package:paynet_app/history/request_history.dart';
import 'package:paynet_app/models/request_madel.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveRequest() async {
  final prefs = await SharedPreferences.getInstance();
  List<String> data = requestHistory.map((e) {
    return jsonEncode({
      'id': e.id,
      'name': e.name,
      'amount': e.amount,
      'status': e.status,
      'dateTime': e.dateTime.toIso8601String(),
    });
  }).toList();
  await prefs.setStringList('history', data);
}
Future<void> loadHistory() async {
  final prefs = await SharedPreferences.getInstance();
  final data = prefs.getStringList('history');
  if (data != null) {
    requestHistory = data.map((e) {
      final data = jsonDecode(e);
      return RequestModel(
        id: data['id'],
        name: data['name'],
        amount: data['amount'],
        status: data['status'],
        dateTime: DateTime.parse(data['dateTime']));
    }).toList();
  }
}
void cancelRequest(String requestId) async {
  final index = requestHistory.indexWhere((e) => e.id == requestId);
  if (index != -1) {
    requestHistory[index].status = 'Отменен';
    saveRequest();
  }
}

