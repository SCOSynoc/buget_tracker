import 'package:budget_tracker/features/spending_history/spd_history_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyControllerProvider = Provider((ref) {
  final historyRepository = ref.read(spendRepositoryProvider);
  return HistoryController( ref: ref,  historyRepository: historyRepository,);
});



class HistoryController {
  final ProviderRef ref;
  final SpdHistoryRepository historyRepository;

  HistoryController({required this.ref,required this.historyRepository});

  Stream<List<dynamic>> getHistoryExpenseData(String category){
    return historyRepository.getExpHistoryList(category);
  }

  Stream<List<dynamic>> getHistoryIncomeData(int date){
    return historyRepository.getIncomeHistoryList(date);
  }
}