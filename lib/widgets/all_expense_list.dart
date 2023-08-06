import 'package:budget_tracker/features/expense/expense_controller.dart';
import 'package:budget_tracker/features/expense/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AllExpenseList extends ConsumerWidget {
  const AllExpenseList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: ref.read(expControllerProvider).getExpenseList(),
        builder: (context, snapshot) {
        List<dynamic> expenseList = snapshot.data ?? [];
        print("the exp is $expenseList");
      return  Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical, // Make it horizontal
            itemCount: expenseList.length,
            itemBuilder: (context, eIndex) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width:MediaQuery.of(context).size.width*0.30,
              decoration:  BoxDecoration(
                color: Colors.black87,
                border: Border(
                  right: BorderSide(color: Colors.red, width: 2),
                  top: BorderSide(color: Colors.red, width: 2),
                  bottom: BorderSide(color: Colors.red, width: 2),
                  left: BorderSide(color: Colors.red, width: 2), ),

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(" - Expense", style: GoogleFonts.acme(fontSize: 23, color: Colors.red, fontWeight: FontWeight.w600),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${expenseList[eIndex]["category"]}",style: GoogleFonts.acme(fontSize: 15, color: Colors.red),),
                        Text("₹ ${expenseList[eIndex]["expense"]} - ${expenseList[eIndex]["date"]} ",style: GoogleFonts.acme(fontSize: 15, color: Colors.red),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      );
    });
  }
}
