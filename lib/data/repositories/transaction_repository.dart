import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qlct/domain/entities/transaction_entity.dart';
import 'package:qlct/data/models/transaction_model.dart';

class TransactionRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<TransactionEntity>> getTransactions() async {
    try {
      final snapshot = await _firestore.collection("transactions").get();
      return snapshot.docs
          .map((doc) => TransactionModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception("Lỗi khi tải giao dịch: ${e.toString()}");
    }
  }

  Future<void> addTransaction(TransactionEntity transaction) async {
    try {
      final transactionModel = TransactionModel(
        id: transaction.id,
        title: transaction.title,
        amount: transaction.amount,
        date: transaction.date,
        isIncome: transaction.isIncome,
      );
      await _firestore
          .collection("transactions")
          .doc(transaction.id)
          .set(transactionModel.toJson());
    } catch (e) {
      throw Exception("Lỗi khi thêm giao dịch: ${e.toString()}");
    }
  }

  Future<void> updateTransaction(TransactionEntity transaction) async {
    try {
      await _firestore
          .collection("transactions")
          .doc(transaction.id)
          .update(transaction.toJson());
    } catch (e) {
      throw Exception("Lỗi khi cập nhật giao dịch: ${e.toString()}");
    }
  }

  Future<void> deleteTransaction(String transactionId) async {
    try {
      await _firestore.collection("transactions").doc(transactionId).delete();
    } catch (e) {
      throw Exception("Lỗi khi xóa giao dịch: ${e.toString()}");
    }
  }
}
