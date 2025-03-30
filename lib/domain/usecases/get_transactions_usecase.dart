import '../entities/transaction_entity.dart';
import '../../data/repositories/transaction_repository.dart';

class GetTransactionsUseCase {
  final TransactionRepository repository;

  GetTransactionsUseCase(this.repository);

  Future<List<TransactionEntity>> execute() async {
    return await repository.getTransactions();
  }
}
