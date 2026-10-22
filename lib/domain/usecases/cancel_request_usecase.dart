import 'package:paynet_app/domain/repositories/history_repository.dart';

class CancelRequestUseCase {
  final HistoryRepository repository;

  CancelRequestUseCase(this.repository);

  Future<void> call(String requestId) async {
    return await repository.cancelRequest(requestId);
  }
}
