import 'package:budget_tracker/features/income/income_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../features/expense/expense_repository.dart';

class AllIncomeList extends ConsumerWidget {
  const AllIncomeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
        stream: ref.read(incomeControllerProvider).getIncomeList(),
        builder: (context, snapshot) {
          List<dynamic> incomeList = snapshot.data ?? [];
          return  Container(
            color: Colors.black87,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical, // Make it horizontal
                itemCount: incomeList.length,
                itemBuilder: (context, eIndex) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width:MediaQuery.of(context).size.width*0.30,
                      decoration:  BoxDecoration(
                        color: Colors.black87,
                        border: Border(
                          top: BorderSide(color: Colors.green, width: 2),
                          bottom: BorderSide(color: Colors.green, width: 2),
                          left: BorderSide(color: Colors.green, width: 2), right: BorderSide(color: Colors.green, width: 2), ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(" + Income ", style: GoogleFonts.acme(fontSize: 23, color: Colors.green, fontWeight: FontWeight.w600),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${incomeList[eIndex]["category"]}",style: GoogleFonts.acme(fontSize: 15, color: Colors.green),),
                                Text("₹ ${incomeList[eIndex]["income"]} - ${incomeList[eIndex]["date"]} ",style: GoogleFonts.acme(fontSize: 15, color: Colors.green),),
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
