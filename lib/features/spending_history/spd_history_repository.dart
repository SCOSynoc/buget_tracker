import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final spendRepositoryProvider = Provider((ref) {
  return SpdHistoryRepository(auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance);
});



class SpdHistoryRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  SpdHistoryRepository({required this.auth,required this.firestore});


  Stream<List<dynamic>> getExpHistoryList(String category){
    return firestore.collection("budget_user").doc(auth.currentUser!.uid)
        .collection("expense")
        .where("category", isEqualTo: category)
        .snapshots()
        .map((event) {
      List<dynamic> dataExpList = [];
      for (var document in event.docs){
        dataExpList.add(document);
      }
      return dataExpList;
    });
  }

  Stream<List<dynamic>> getIncomeHistoryList(int month){
    return firestore.collection("budget_user").doc(auth.currentUser!.uid)
        .collection("Income")
        .where("month", isEqualTo:month)
        .snapshots()
        .map((event) {
      List<dynamic> dataIncList = [];
      for (var document in event.docs){
        dataIncList.add(document);
      }
      return dataIncList;
    });
  }



}