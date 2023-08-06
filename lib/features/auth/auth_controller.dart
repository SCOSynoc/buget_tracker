import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userAuthProvider = FutureProvider((ref) {
  final currentUserAuth = ref.watch(authControllerProvider);
  return currentUserAuth.getCurrentUserAuthData();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({required this.ref,required this.authRepository});


  void signInWithEmail(String email , String password, BuildContext context, String mobile, String name){
    authRepository.signInWithEmailAndPassword(email: email, name: name, context: context, password: password, mobile: mobile,);

  }

  void logInWithEmail(String email , String password, BuildContext context){
    authRepository.logInWithEmailAndPassword(email, password, context);
  }

  Future<Map?> getCurrentUserAuthData() async{
    Map? user = await authRepository.getCurrentUserData();
    return user;
  }

  void signOutUser(BuildContext context){
    authRepository.signOutUser(context);
  }


  void updateBudget({required String monthly, required String annually}){
    authRepository.updateUserBudget(monthly: monthly, annually: annually);
  }



}