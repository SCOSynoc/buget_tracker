import 'package:budget_tracker/features/auth/auth_controller.dart';
import 'package:budget_tracker/screens/sign_up_screen.dart';
import 'package:budget_tracker/utils/utils.dart';
import 'package:budget_tracker/widgets/common_button.dart';
import 'package:budget_tracker/widgets/common_textFeild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dashboard_screen.dart';

class LoginPage extends ConsumerWidget {


  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            CommonTextField(
              obscureText: false, label: 'Email', icon: Icons.email, controller: _emailController,),
            SizedBox(height: 10),
             CommonTextField(
              obscureText: true, label: "Password", icon: Icons.lock, controller: _passwordController,),
            SizedBox(height: 20),
            CommonElevatedButton(text: "Login", onPressed: (){
              ref.read(authControllerProvider).logInWithEmail(_emailController.text, _passwordController.text, context);
            },),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                navigateToScreen(context, SignUpScreen());
              },
              child: Text("Sign Up"),
              style: TextButton.styleFrom(primary: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

}