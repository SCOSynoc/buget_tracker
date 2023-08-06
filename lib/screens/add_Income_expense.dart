import 'package:budget_tracker/screens/expense_screen.dart';
import 'package:budget_tracker/screens/income_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddIncomeExpenses extends StatelessWidget {
  const AddIncomeExpenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabViewScreen();
  }
}



class TabViewScreen extends StatefulWidget {
  @override
  _TabViewScreenState createState() => _TabViewScreenState();
}

class _TabViewScreenState extends State<TabViewScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 2 tabs for Expense and Income
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        automaticallyImplyLeading: false,
        title: Text('Expense and Income', style: GoogleFonts.acme(color: Colors.white70),),
        bottom: TabBar(
          indicatorColor: Colors.purpleAccent.shade200,
          labelStyle: GoogleFonts.acme(fontSize: 18, color: Colors.black87),
          indicatorSize: TabBarIndicatorSize.tab,
          controller: _tabController,
          tabs: [
            Tab(text: 'Expense'),
            Tab(text: 'Income'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Expense Tab Content
          Center(
            child: ExpenseScreen(),
          ),
          // Income Tab Content
          Center(
            child: IncomeScreen(),
          ),
        ],
      ),
    );
  }
}
