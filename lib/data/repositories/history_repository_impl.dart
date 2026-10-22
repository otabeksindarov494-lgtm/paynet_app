import 'package:paynet_app/data/datasources/history_local_datasource.dart';
import 'package:paynet_app/data/models/request_model.dart';
import 'package:paynet_app/domain/entities/request_entity.dart';
import 'package:paynet_app/domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryLocalDataSource localDataSource;

  HistoryRepositoryImpl(this.localDataSource);

  @override
  Future<List<RequestEntity>> getHistory() async {
    return await localDataSource.getHistory();
  }

  @override
  Future<void> saveHistory(List<RequestEntity> history) async {
    final models = history.map((e) => RequestModel.fromEntity(e)).toList();
    await localDataSource.saveHistory(models);
  }

  @override
  Future<void> cancelRequest(String requestId) async {
    await localDataSource.cancelRequest(requestId);
  }
}
