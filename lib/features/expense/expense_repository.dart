import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../utils/utils.dart';


final expenseRepositoryProvider = Provider((ref) {
  return ExpenseRepository(auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance);
});


class ExpenseRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  ExpenseRepository({required this.auth,required this.firestore});


  void addExpensesToFirebase({required String category, required double amount, required String date}) async{
    loaderNotifier.value = true;
    try{
      String uid = auth.currentUser!.uid;
      String uuid_expense = const Uuid().v1();
      await firestore.collection("budget_user").doc(uid).collection("expense").doc(uuid_expense).set({
        "expense": amount, "category": category, "date": date, "user_id": uid, "exp_doc_id": uuid_expense, "month": DateFormat("dd/MM/yyyy").parse(date).month}
      );
      showToast("Expense added successfully");
    } on FirebaseException catch(e){
      print("enter error $e");
      showToast("Something went wrong report this bug");
    }
  }


  Stream<List<dynamic>> getExpenseLists(){
       return firestore.collection("budget_user").doc(auth.currentUser!.uid)
           .collection("expense")
           .orderBy("date")
           .snapshots()
           .map((event) {
             List<dynamic> dataExpList = [];
             for (var document in event.docs){
               dataExpList.add(document);
             }
             print("exp data is $dataExpList");
             // totalExpense(dataExpList);
             expenseListValueNotifier.value = dataExpList;
             return dataExpList;
       });
  }

  void totalExpense(){
    double total = 0;
    List<dynamic> calculateAmt = expenseListValueNotifier.value;

    for(var item in calculateAmt){
       total +=  double.parse(item["expense"].toString()) ;
    }
    log("the toatal amount is $total");
    amountValueNotifier.value = total;
  }

}