import 'package:paynet_app/domain/entities/request_entity.dart';
import 'package:paynet_app/domain/repositories/history_repository.dart';

class GetHistoryUseCase {
  final HistoryRepository repository;

  GetHistoryUseCase(this.repository);

  Future<List<RequestEntity>> call() async {
    return await repository.getHistory();
  }
}
