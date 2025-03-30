import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlct/domain/entities/transaction_entity.dart';
import 'package:qlct/domain/usecases/add_transactions_usecase.dart';
import 'package:qlct/domain/usecases/delete_transactions_usecase.dart';
import 'package:qlct/domain/usecases/get_transactions_usecase.dart';
import 'package:qlct/data/repositories/transaction_repository.dart';
import 'package:qlct/domain/usecases/update_transaction_usecase.dart';
import 'transaction_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final GetTransactionsUseCase getTransactionsUseCase;
  final AddTransactionUseCase addTransactionUseCase;
  final UpdateTransactionUseCase updateTransactionUseCase;
  final DeleteTransactionUseCase deleteTransactionUseCase;
  final TransactionRepository transactionRepository;

  TransactionCubit({
    required this.getTransactionsUseCase,
    required this.addTransactionUseCase,
    required this.updateTransactionUseCase,
    required this.deleteTransactionUseCase,
    required this.transactionRepository,
  }) : super(TransactionInitial());

  void fetchTransactions() async {
    emit(TransactionLoading());
    try {
      final transactions = await getTransactionsUseCase.execute();
      emit(TransactionLoaded(transactions));
    } catch (e) {
      emit(TransactionError("Lỗi khi tải dữ liệu: ${e.toString()}"));
    }
  }

  void addTransaction(TransactionEntity transaction) async {
    try {
      await addTransactionUseCase.execute(transaction);
      fetchTransactions();
    } catch (e) {
      emit(TransactionError("Lỗi khi thêm giao dịch: ${e.toString()}"));
    }
  }

  void updateTransaction(TransactionEntity transaction) async {
    try {
      await updateTransactionUseCase.execute(transaction);
      fetchTransactions();
    } catch (e) {
      emit(TransactionError("Lỗi khi cập nhật giao dịch: ${e.toString()}"));
    }
  }

  Future<void> deleteTransaction(String transactionId) async {
    try {
      await deleteTransactionUseCase.execute(transactionId);
      fetchTransactions();

    } catch (e) {
      emit(TransactionError("Lỗi khi xóa giao dịch: ${e.toString()}"));
    }
  }



}
