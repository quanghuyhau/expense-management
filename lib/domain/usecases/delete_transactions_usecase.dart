import 'package:qlct/data/repositories/transaction_repository.dart';

class DeleteTransactionUseCase {
  final TransactionRepository repository;

  DeleteTransactionUseCase(this.repository);

  Future<void> execute(String transactionId) async {
    await repository.deleteTransaction(transactionId);
  }
}

