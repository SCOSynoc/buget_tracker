import 'package:budget_tracker/screens/add_Income_expense.dart';
import 'package:budget_tracker/screens/all_spending_Screen.dart';
import 'package:budget_tracker/screens/budget_screen.dart';
import 'package:budget_tracker/screens/home_screen.dart';
import 'package:budget_tracker/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, this.from});
  final String? from;
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0 ;
  final List<Widget> _screens = [
    AllSpendingScreen(),
    HomeScreen(),
    BudgetScreen(),
    AddIncomeExpenses(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = widget.from == "SignUp"? 2 : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple.shade700,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        fixedColor: Colors.white70,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.price_check_rounded,),
            label: 'Spend',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history,),
            label: 'History',
          ),
          BottomNavigationBarItem(
            backgroundColor:Colors.purple.shade700 ,
            icon: Icon(Icons.price_change,),
            label: 'Budget',
          ),
          BottomNavigationBarItem(
            backgroundColor:Colors.purple.shade700 ,
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person ),
            backgroundColor:Colors.white70 ,
            label: 'Profile',
          ),

        ],
      ),
    );
  }
}





