import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../utils/utils.dart';


final incomeRepositoryProvider = Provider((ref) {
  return IncomeRepository(auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance);
});


class IncomeRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  IncomeRepository({required this.auth,required this.firestore});


  void addIncomesToFirebase({required String category, required double amount, required String date}) async{
    loaderNotifier.value = true;
    try{
      String uid = auth.currentUser!.uid;
      String uuid_income = const Uuid().v1();
      await firestore.collection("budget_user").doc(uid).collection("Income").doc(uuid_income).set({
        "income": amount, "category": category, "date": date, "user_id": uid, "exp_doc_id": uuid_income, "month": DateFormat("dd/MM/yyyy").parse(date).month}
      );
      showToast("Income added successfully");
    } on FirebaseException catch(e){
      print("enter error $e");
      showToast("Something went wrong report this bug");
    }
  }


  Stream<List<dynamic>> getIncomeLists(){
    return firestore.collection("budget_user").doc(auth.currentUser!.uid)
        .collection("Income")
        .orderBy("date")
        .snapshots()
        .map((event) {
      List<dynamic> dataExpList = [];
      for (var document in event.docs){
        dataExpList.add(document);
      }

      print("in income this is $dataExpList");
      incomeListValueNotifier.value = dataExpList;
      return dataExpList;
    });
  }

  void totalIncome(){
    double total = 0;
    List<dynamic> calculateAmt = incomeListValueNotifier.value;
    print("Income is of  $calculateAmt");
    for(var item in calculateAmt){
      total +=  double.parse(item["income"].toString()) ;
    }
    log("the toatal income amount is $total");
    incomeValueNotifier.value = total;
  }

}