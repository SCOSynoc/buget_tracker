import 'package:budget_tracker/features/spending_history/history_controller.dart';
import 'package:budget_tracker/utils/utils.dart';
import 'package:budget_tracker/widgets/category_chips.dart';
import 'package:budget_tracker/widgets/history_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String selectedCategory = "Bills";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
        appBar: AppBar(title: Text("Spending history"), centerTitle: true, backgroundColor: Colors.purple,),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: CategoryChips(),
              ),
            ),

            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ValueListenableBuilder(
                    valueListenable: sortValueNotifierInHomeScreen,
                    builder: (BuildContext context, value, Widget? child) {
                      return StreamBuilder(
                        stream: ref.read(historyControllerProvider).getHistoryExpenseData(sortValueNotifierInHomeScreen.value),
                          builder: (context, snapshot){
                          final data = snapshot.data ?? [];
                          if(snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator( color: Colors.purple,),);
                          }
                        return HistoryContainer(expenseList: data);
                      });
                }
                ),
              ),
            )
          ],
        )
    );
  }
}

