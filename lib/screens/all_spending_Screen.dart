import 'package:budget_tracker/widgets/all_expense_list.dart';
import 'package:budget_tracker/widgets/all_income_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllSpendingScreen extends StatefulWidget {
  const AllSpendingScreen({Key? key}) : super(key: key);

  @override
  State<AllSpendingScreen> createState() => _AllSpendingScreenState();
}

class _AllSpendingScreenState extends State<AllSpendingScreen> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 2 tabs for Expense and Income
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Balance', style:GoogleFonts.acme(color: Colors.white70) ,),
        bottom: TabBar(
          labelStyle: GoogleFonts.acme(),
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
            child: AllExpenseList(),
          ),
          // Income Tab Content
          Center(
            child: AllIncomeList(),
          ),
        ],
      ),
    );
  }
}
