import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:qlct/presentation/cubit/transaction/transaction_cubit.dart';
import 'package:qlct/domain/entities/transaction_entity.dart';
import 'package:qlct/presentation/cubit/transaction/transaction_state.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thống kê chi tiêu"),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TransactionLoaded) {
            final transactions = state.transactions.where((t) => !t.isIncome).toList();

            if (transactions.isEmpty) {
              return const Center(
                child: Text("Không có dữ liệu để thống kê."),
              );
            }

            final groupedByMonth = groupBy(transactions, (TransactionEntity t) {
              return DateFormat("MM/yyyy").format(t.date);
            });

            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Expanded(child: _buildPieChart(groupedByMonth)),
                ],
              ),
            );
          } else if (state is TransactionError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildPieChart(Map<String, List<TransactionEntity>> groupedTransactions) {
    final List<PieChartSectionData> sections = groupedTransactions.entries.map((entry) {
      double totalAmount = entry.value.fold(0, (sum, t) => sum + t.amount);
      return PieChartSectionData(
        value: totalAmount,
        title: '${entry.key}\n${totalAmount.toStringAsFixed(1)} VND',
        color: Colors.primaries[entry.key.hashCode % Colors.primaries.length],
        radius: 80,
        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Chi tiêu theo tháng", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: sections,
                  borderData: FlBorderData(show: false),
                  centerSpaceRadius: 40,
                  sectionsSpace: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

