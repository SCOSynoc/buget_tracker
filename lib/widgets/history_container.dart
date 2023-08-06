import 'package:budget_tracker/features/spending_history/history_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HistoryContainer extends ConsumerWidget {
  const HistoryContainer({Key? key, required this.expenseList}) : super(key: key);
  final List<dynamic> expenseList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.of(context).size.width*0.9,
      height: MediaQuery.of(context).size.height,
      child: AspectRatio(
        aspectRatio: 1,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical, // Make it horizontal
            itemCount: expenseList.length,
            itemBuilder: (context, eIndex) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                 Container(
                   width:MediaQuery.of(context).size.width*0.30,
                   decoration:  BoxDecoration(
                       color: Colors.black87,
                       border: Border(
                         right: BorderSide(color: Colors.red, width: 0.5),
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
                             Text("₹ ${expenseList[eIndex]["expense"]}  ${expenseList[eIndex]["date"]} ",style: GoogleFonts.acme(fontSize: 15, color: Colors.red),),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),

                 Expanded(
                   child: Container(
                     width: MediaQuery.of(context).size.width*0.60,
                     decoration: BoxDecoration(
                       color: Colors.black87,
                       border: Border(
                         top: BorderSide(color: Colors.green, width: 2),
                         bottom: BorderSide(color: Colors.green, width: 2),
                         right: BorderSide(color: Colors.green, width: 2),
                         left: BorderSide(color: Colors.green, width: 2)
                       ),
                     ),


                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text("+ Income", style: GoogleFonts.acme(fontSize: 23, color: Colors.green, fontWeight: FontWeight.w600),),
                         ),
                         StreamBuilder(
                          stream: ref.read(historyControllerProvider).getHistoryIncomeData(expenseList[eIndex]["month"]) ,
                          builder: (context, snapshot) {
                           final data =  snapshot.data ?? [];
                           return ListView.builder(
                           shrinkWrap: true,
                           scrollDirection: Axis.vertical, // Make it horizontal
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width*0.25,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${data[index]["category"]}", style: GoogleFonts.acme(color: Colors.green),),
                                      Text("₹ ${data[index]["income"]} - ${data[index]["date"]}", style: GoogleFonts.acme(color: Colors.green))
                                    ],),
                                 ),
                              );
                              }
                              );
                         }
                         )

                       ],
                     ),
                   ),
                 )
            ],),
          );
        }),
      ),
    );
  }
}
