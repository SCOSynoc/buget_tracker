import 'dart:developer';

import 'package:budget_tracker/screens/dashboard_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../screens/login_screen.dart';
import '../../utils/utils.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance),
);


class AuthRepository {
  final  FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({required this.auth, required this.firestore});


  void signInWithEmailAndPassword({required String email ,required String name, required BuildContext context,required String password, required String mobile}) async {
    loaderNotifier.value = true;
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password).whenComplete(() async {
       await auth.signInWithEmailAndPassword(email: email, password: password);
      }
      ).whenComplete(() {
        saveUserToFirebase(email: email, name: name, mobile: mobile, context: context,);
      });

    } catch(e){
      print("Errror $e");
      showToast("Something went wrong please report this bug");
    }
  }


  void saveUserToFirebase({required String email ,required String name, required String mobile, required BuildContext context}) async{
    try{
       String uid = auth.currentUser!.uid;
       await firestore.collection("budget_user").doc(uid).set({"name": name, "email": email, "mobile_num": mobile, "uid": uid}).then((value) {
         showToast("SignedIn successfully");
         navigateAndRemovePush(context, const DashboardScreen(from: "SignUp",));
       }).onError((error, stackTrace) {
            log("here data error is $error and $stackTrace");
            loaderNotifier.value = false;
       });

    }catch(e){
      loaderNotifier.value = false;
      throw Exception(e);
    }

  }


  void logInWithEmailAndPassword(String email , String password, BuildContext context) async {

    loaderNotifier.value = true;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password).whenComplete(() =>
          navigateAndRemovePush(context, DashboardScreen())
      ).catchError((error) {
        loaderNotifier.value = false;
        throw Exception(error);
      });
      showToast("logged in successfully");
    } on FirebaseAuthException catch(e){
      /*showSnackBar(context: context, content: "${e.message}");*/
      showToast("Something went wrong report the bug");
    }
  }

  Future<Map?> getCurrentUserData() async{
    Map? user;
    if(auth.currentUser == null){
      return user;
    }else{
      var userData = await firestore.collection("budget_user").doc(auth.currentUser!.uid).get();
      print("here user uid is ${auth.currentUser!.uid}");
      if(userData.data() != null){
        user = userData.data()!;
      }
      print("here user is $user");
      return user;
    }
  }

  void signOutUser(BuildContext context){
    auth.signOut().whenComplete(() => navigateAndRemovePush(context, LoginPage()));
  }


  void updateUserBudget({required String monthly, required String annually}){
    loaderNotifier.value = true;
    firestore.collection("budget_user").doc(auth.currentUser!.uid).update({
      "monthly_budget": monthly,
      "annual_budget": annually
    }).whenComplete(() {
      loaderNotifier.value = false;
      showToast("Budget added successfully");
    });
  }
}
