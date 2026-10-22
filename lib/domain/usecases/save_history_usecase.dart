import 'package:paynet_app/domain/entities/request_entity.dart';
import 'package:paynet_app/domain/repositories/history_repository.dart';

class SaveHistoryUseCase {
  final HistoryRepository repository;

  SaveHistoryUseCase(this.repository);

  Future<void> call(List<RequestEntity> history) async {
    return await repository.saveHistory(history);
  }
}
