import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'income_repository.dart';

final incomeControllerProvider = Provider((ref) {
  final incomeRepository = ref.read(incomeRepositoryProvider);
  return IncomeController( ref: ref, incomeRepository:incomeRepository,);
});


class IncomeController {
  final ProviderRef ref;
  final IncomeRepository incomeRepository;

  IncomeController( {required this.incomeRepository, required this.ref,});


  void addIncomeData( {required String category, required double amount, required String date}){
    incomeRepository.addIncomesToFirebase(category: category, amount: amount, date: date);
  }

  Stream<List<dynamic>> getIncomeList(){
    return incomeRepository.getIncomeLists();
  }

  void incomeTotalCount(){
    incomeRepository.totalIncome();
  }


}