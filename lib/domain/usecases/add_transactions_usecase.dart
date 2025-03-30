import 'package:qlct/domain/entities/transaction_entity.dart';
import 'package:qlct/data/repositories/transaction_repository.dart';

class AddTransactionUseCase {
  final TransactionRepository repository;

  AddTransactionUseCase(this.repository);

  Future<void> execute(TransactionEntity transaction) async {
    return await repository.addTransaction(transaction);
  }
}
