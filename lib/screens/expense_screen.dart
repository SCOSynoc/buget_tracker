import 'package:budget_tracker/features/expense/expense_controller.dart';
import 'package:budget_tracker/utils/utils.dart';
import 'package:budget_tracker/widgets/common_button.dart';
import 'package:budget_tracker/widgets/common_textFeild.dart';
import 'package:budget_tracker/widgets/dropdown_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/date_picker_widget.dart';

class ExpenseScreen extends ConsumerWidget {
   ExpenseScreen({Key? key}) : super(key: key);


   TextEditingController _expenseController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double  amount = 0.0;
    ref.read(expControllerProvider).totalExpenseCount();
    return Scaffold(
      backgroundColor: Colors.black87,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.deepPurple,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Center(child: ValueListenableBuilder(
                  valueListenable: amountValueNotifier ,
                  builder: (BuildContext context, value, Widget? child) {
                    return Text("Total Expense ₹$value", style: GoogleFonts.acme(fontWeight: FontWeight.w800, fontSize: 30),);
                  },
                )
              ),
            ),
            Container(
              decoration:BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16,),
                const CategoryDropdown(categories: [
                  'Bills',
                  'Travels',
                  'Personal',
                  'Food',
                  "Festivals",
                  "Entertainment",
                  "Fun",
                ],),
                SizedBox(height: 16,),
                SizedBox(
                    width: MediaQuery.of(context).size.width*0.9,
                    child: CommonTextField(obscureText: false, label: "Enter expense", icon: Icons.add, controller: _expenseController)),
                SizedBox(height: 16,),
                SizedBox(
                    width: MediaQuery.of(context).size.width*0.9,
                    child: DatePickerWidget()),
                SizedBox(height: 16,),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.9,
                  child: ValueListenableBuilder(valueListenable: categoryValueNotifier,
                    builder: (BuildContext context, value, Widget? child) {
                      return CommonElevatedButton(text: 'Add Expense', onPressed: () {
                             amount = double.parse(_expenseController.text);
                           ref.read(expControllerProvider).addExpenseData(category: value, amount: amount, date: dateValueNotifier.value);
                      },);
                    },)

                )
              ],
            ),
            )
        ],
        ),
      ),
    );
  }
}
