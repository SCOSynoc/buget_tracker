import 'package:budget_tracker/features/income/income_controller.dart';
import 'package:budget_tracker/widgets/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/utils.dart';
import '../widgets/common_button.dart';
import '../widgets/common_textFeild.dart';
import '../widgets/dropdown_category.dart';

class IncomeScreen extends ConsumerWidget {
   IncomeScreen({Key? key}) : super(key: key);

  TextEditingController _incomeController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double  amount = 0.0;
    ref.read(incomeControllerProvider).incomeTotalCount();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.deepPurple,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Center(child: ValueListenableBuilder(
                  valueListenable: incomeValueNotifier,
                  builder: (BuildContext context, value, Widget? child) {
                    return Text("Total income ₹$value", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),);
                  },)
              ),),
            Container(
              decoration:BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16,),
                  CategoryDropdown(categories: ["Active income", "Passive income", "Portfolio income", "Salary"], ),
                  SizedBox(height: 16,),
                  SizedBox(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: CommonTextField(obscureText: false, label: "Enter Income", icon: Icons.add, controller: _incomeController)),
                  SizedBox(height: 16,),
                  SizedBox(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: DatePickerWidget()),
                  SizedBox(height: 16,),
                  SizedBox(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: ValueListenableBuilder(valueListenable: categoryValueNotifier,
                        builder: (BuildContext context, value, Widget? child) {
                          return CommonElevatedButton(text: 'Add Income', onPressed: () {
                            amount = double.parse(_incomeController.text);
                            ref.read(incomeControllerProvider).addIncomeData(category: value, amount: amount, date: dateValueNotifier.value);
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
