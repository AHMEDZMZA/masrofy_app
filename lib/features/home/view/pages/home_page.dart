import 'package:flutter/material.dart';
import 'package:masrofy/features/home/view/widgets/home_bottom_navigation.dart';
import '../tabs/expenses_tab.dart';
import '../tabs/home_tab.dart';
import '../tabs/more_tab.dart';
import '../tabs/reports_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentNavIndex = 0;
  final List<Widget> _tab = [
    HomeTab(),
    ReportsTab(),
    SizedBox.shrink(),
    ExpensesTab(),
    MoreTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _currentNavIndex, children: _tab),
      ),
      bottomNavigationBar: HomeBottomNavigation(
        currentIndex: _currentNavIndex,
        onTap: (int value) {
          setState(() {
            _currentNavIndex = value;
          });
        },
      ),
    );
  }
}
