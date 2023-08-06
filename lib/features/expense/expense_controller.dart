import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'expense_repository.dart';

final expControllerProvider = Provider((ref) {
  final expRepository = ref.read(expenseRepositoryProvider);
  return ExpenseController(expenseRepository: expRepository, ref: ref, );
});


class ExpenseController {
    final ProviderRef ref;
    final ExpenseRepository expenseRepository;

    ExpenseController( {required this.expenseRepository, required this.ref,});


    void addExpenseData( {required String category, required double amount, required String date}){
      expenseRepository.addExpensesToFirebase(category: category, amount: amount, date: date);
    }

    Stream<List<dynamic>> getExpenseList(){
      return expenseRepository.getExpenseLists();
    }

    void totalExpenseCount(){
       expenseRepository.totalExpense();
    }


}