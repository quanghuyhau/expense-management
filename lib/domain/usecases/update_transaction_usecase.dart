import 'package:qlct/domain/entities/transaction_entity.dart';
import 'package:qlct/data/repositories/transaction_repository.dart';

class UpdateTransactionUseCase {
  final TransactionRepository repository;

  UpdateTransactionUseCase(this.repository);

  Future<void> execute(TransactionEntity transaction) async {
    return await repository.updateTransaction(transaction);
  }
}
