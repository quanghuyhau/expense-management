import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:qlct/presentation/cubit/transaction/transaction_cubit.dart';
import 'package:qlct/domain/entities/transaction_entity.dart';
import 'package:qlct/presentation/cubit/transaction/transaction_state.dart';
import 'package:qlct/presentation/screens/add_transaction/add_trasaction_screen.dart';
import 'package:collection/collection.dart';

class TransactionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý giao dịch"),
        backgroundColor: Colors.lightGreenAccent,
        elevation: 2,
      ),
      body: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TransactionLoaded) {
            final transactions = state.transactions;

            if (transactions.isEmpty) {
              return const Center(
                child: Text(
                  "Chưa có giao dịch nào!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              );
            }

            final groupedTransactions = groupBy(transactions, (TransactionEntity t) {
              return DateFormat("dd/MM/yyyy").format(t.date);
            });

            return ListView(
              padding: const EdgeInsets.all(12),
              children: groupedTransactions.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "📅 ${entry.key}",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                      ),
                    ),
                    ...entry.value.map((transaction) => _buildTransactionCard(context, transaction)),
                  ],
                );
              }).toList(),
            );
          } else if (state is TransactionError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTransaction(context),
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildTransactionCard(BuildContext context, TransactionEntity transaction) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => _editTransaction(context, transaction),
              backgroundColor: Colors.blue,
              icon: Icons.edit,
              label: "Sửa",
            ),
            SlidableAction(
              onPressed: (_) => _deleteTransaction(context, transaction.id),
              backgroundColor: Colors.red,
              icon: Icons.delete,
              label: "Xóa",
            ),
          ],
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text(
              transaction.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              "${_formatCurrency(transaction.amount)}",
              style: TextStyle(color: Colors.grey.shade600),
            ),
            leading: CircleAvatar(
              backgroundColor: transaction.isIncome ? Colors.green : Colors.red,
              child: Icon(
                transaction.isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _addTransaction(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTransactionScreen()),
    );
  }

  void _editTransaction(BuildContext context, TransactionEntity transaction) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTransactionScreen(transaction: transaction),
      ),
    );
  }

  void _deleteTransaction(BuildContext context, String transactionId) {
    context.read<TransactionCubit>().deleteTransaction(transactionId);
  }

  String _formatCurrency(double amount) {
    final formatCurrency = NumberFormat("#,### VND", "vi_VN");
    return formatCurrency.format(amount);
  }
}
