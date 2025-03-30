import 'package:flutter/material.dart';
import 'package:qlct/presentation/screens/profile/profile_screen.dart';
import 'package:qlct/presentation/screens/statics/statistics_screen.dart';
import 'package:qlct/presentation/screens/transaction/transaction_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    TransactionScreen(),
    StatisticsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Giao dịch",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Thống kê",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Tài khoản",
          ),
        ],
      ),
    );
  }
}
