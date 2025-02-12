import 'package:final_project/controller/auth_controller.dart';
import 'package:final_project/service/api_service.dart';
import 'package:final_project/theme/app_color.dart';
import 'package:final_project/view/widgets/login/have_account.dart';
import 'package:final_project/view/widgets/text_form.dart';
import 'package:final_project/view/widgets/login/login_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _authController = AuthController(ApiService());

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor:  AppColor.primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.secondaryBackgroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
              child: SingleChildScrollView(
                child: Form(
                 key: _formKey,
                 child: Column( 
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     Text(
                      "Login here",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColor.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Welcome back! You've been missed!",
                      style: TextStyle(color: AppColor.textPrimaryColor),
                    ),
                    SizedBox(height: 20),
                    TextForm(
                      label: 'Email',
                      controller: _emailController,
                      icon: Icons.email,
                      isPassword: false,
                      isEmail: true,
                      isNumber: false,
                      isName: false,
                    ),
                    const SizedBox(height: 20),
                    TextForm(
                      label: 'Password',
                      controller: _passwordController,
                      icon: Icons.lock,
                      isPassword: true,
                      isEmail: false,
                      isNumber: false,
                      isName: false,
                    ),
                    const SizedBox(height: 20),
                    LoginButton(
                      formKey: _formKey,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      authController: _authController,
                    ),
                    const SizedBox(height: 20),
                    HaveAccount(),
                  ],
                ),
                            ),
              ),
            ),
        ),
      ),
    );
  }
}