import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlct/data/models/transaction_model.dart';
import 'package:qlct/domain/entities/transaction_entity.dart';
import 'package:qlct/presentation/cubit/transaction/transaction_cubit.dart';

class AddTransactionScreen extends StatefulWidget {
  final TransactionEntity? transaction;

  const AddTransactionScreen({Key? key, this.transaction}) : super(key: key);

  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isIncome = false;
  bool _isEditing = false;
  String? _transactionId;

  @override
  void initState() {
    super.initState();
    if (widget.transaction != null) {
      _isEditing = true;
      _transactionId = widget.transaction!.id;
      _titleController.text = widget.transaction!.title;
      _amountController.text = widget.transaction!.amount.toString();
      _isIncome = widget.transaction!.isIncome;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? "Sửa giao dịch" : "Thêm giao dịch"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Tiêu đề"),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: "Số tiền"),
              keyboardType: TextInputType.number,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Loại giao dịch:"),
                Switch(
                  value: _isIncome,
                  onChanged: (value) => setState(() => _isIncome = value),
                ),
                Text(_isIncome ? "Thu nhập" : "Chi tiêu"),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTransaction,
              child: Text(_isEditing ? "Cập nhật" : "Thêm giao dịch"),
            ),
          ],
        ),
      ),
    );
  }

  void _saveTransaction() {
    final title = _titleController.text.trim();
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (title.isEmpty || amount <= 0) return;

    final transaction = TransactionModel(
      id: _isEditing ? _transactionId! : DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
      isIncome: _isIncome,
    );

    if (_isEditing) {
      context.read<TransactionCubit>().updateTransaction(transaction);
    } else {
      context.read<TransactionCubit>().addTransaction(transaction);
    }

    Navigator.pop(context);
  }
}
