import 'package:budget_tracker/features/auth/auth_controller.dart';
import 'package:budget_tracker/widgets/common_button.dart';
import 'package:budget_tracker/widgets/common_textFeild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BudgetScreen extends ConsumerWidget {

  TextEditingController _monthlyController = TextEditingController();
  TextEditingController _annualController = TextEditingController();


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(title: Text("Budget"), backgroundColor: Colors.purple,),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("Add Monthly budget", style: TextStyle(color: Colors.white70, fontSize: 25),),
              ),
              CommonTextField(obscureText: false, label: 'Enter budget', icon: Icons.price_change_outlined, controller: _monthlyController,),
              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("Add annual budget",style: TextStyle(color: Colors.white70, fontSize: 25)),
              ),
              CommonTextField(obscureText: false, label: 'Enter budget', icon: Icons.price_change_outlined, controller: _annualController,),
              SizedBox(height: 26,),
              SizedBox(
                  width: MediaQuery.of(context).size.width *0.9,
                  child: CommonElevatedButton(text: "Add budgets", onPressed: (){
                     ref.read(authControllerProvider).updateBudget(monthly:_monthlyController.text , annually: _annualController.text);
                  },))
            ],
          ),
        ),
      ),
    );
  }
}
