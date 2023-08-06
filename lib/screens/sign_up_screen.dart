import 'package:budget_tracker/features/auth/auth_controller.dart';
import 'package:budget_tracker/screens/dashboard_screen.dart';
import 'package:budget_tracker/utils/utils.dart';
import 'package:budget_tracker/widgets/common_textFeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/common_button.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _mobileNumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Colors.purple.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CommonTextField(
              obscureText: false, label: 'Name', icon: Icons.email, controller: _nameController,),
            SizedBox(height: 16),
            CommonTextField(
              obscureText: false, label: 'Email', icon: Icons.email, controller: _emailController,),
            SizedBox(height: 16),
            CommonTextField(
              obscureText: true, label: "Password", icon: Icons.lock, controller: _passwordController,),
            SizedBox(height: 16),
            CommonTextField(
              obscureText: false, label: 'Mobile Number', icon: Icons.lock, controller: _mobileNumController,),
            SizedBox(height: 24),
            CommonElevatedButton(text: 'Sign Up', onPressed: () {
              _signUpPressed();
            },)

          ],
        ),
      ),
    );
  }

  void _signUpPressed() {
    // You can implement the sign-up logic here
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String mobileNum = _mobileNumController.text;

    // For now, let's just print the user details as an example
    print('Name: $name');
    print('Email: $email');
    print('Password: $password');
    print('Mobile Number: $mobileNum');
   ref.read(authControllerProvider).signInWithEmail(email, password, context, mobileNum, name);
  }
}



