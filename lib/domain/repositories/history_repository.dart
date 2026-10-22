import 'package:paynet_app/domain/entities/request_entity.dart';

abstract class HistoryRepository {
  Future<List<RequestEntity>> getHistory();
  Future<void> saveHistory(List<RequestEntity> history);
  Future<void> cancelRequest(String requestId);
}
