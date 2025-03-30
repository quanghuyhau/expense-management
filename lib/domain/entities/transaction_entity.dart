class TransactionEntity {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final bool isIncome;

  TransactionEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.isIncome,
  });

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
