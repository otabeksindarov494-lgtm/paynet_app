import 'dart:convert';
import 'package:paynet_app/data/models/request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HistoryLocalDataSource {
  Future<List<RequestModel>> getHistory();
  Future<void> saveHistory(List<RequestModel> history);
  Future<void> cancelRequest(String requestId);
}

class HistoryLocalDataSourceImpl implements HistoryLocalDataSource {
  @override
  Future<List<RequestModel>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('history');
    if (data == null) return [];
    return data.map((e) => RequestModel.fromJson(jsonDecode(e))).toList();
  }

  @override
  Future<void> saveHistory(List<RequestModel> history) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> data = history.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('history', data);
  }

  @override
  Future<void> cancelRequest(String requestId) async {
    final history = await getHistory();
    final index = history.indexWhere((e) => e.id == requestId);
    if (index != -1) {
      history[index].status = 'Отменен';
      await saveHistory(history);
    }
  }
}
