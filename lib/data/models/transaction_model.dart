import '../../domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    required String id,
    required String title,
    required double amount,
    required DateTime date,
    required bool isIncome,
  }) : super(id: id, title: title, amount: amount, date: date, isIncome: isIncome);

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      title: json['title'],
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date']),
      isIncome: json['isIncome'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'isIncome': isIncome,
    };
  }
}
