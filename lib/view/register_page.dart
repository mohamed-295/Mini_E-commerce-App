import 'package:final_project/controller/auth_controller.dart';
import 'package:final_project/service/api_service.dart';
import 'package:final_project/theme/app_color.dart';
import 'package:final_project/view/login_page.dart';
import 'package:final_project/view/widgets/register/register_button.dart';
import 'package:final_project/view/widgets/text_form.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _authController =
      AuthController(ApiService());
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: AppColor.primaryColor,
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
                  children: [
                     Text(
                      "Register here",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 10),
                     Text(
                      "Welcome! Let's get you started!",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(height: 10),
                    TextForm(
                      label: 'First Name',
                      controller: _firstNameController,
                      icon: Icons.person,
                      isPassword: false,
                      isEmail: false,
                      isNumber: false,
                      isName: true,
                    ),
                    TextForm(
                      label: 'Last Name',
                      controller: _lastNameController,
                      icon: Icons.person,
                      isPassword: false,
                      isEmail: false,
                      isNumber: false,
                      isName: true,
                    ),
                    TextForm(
                      label: 'Phone',
                      controller: _phoneController,
                      icon: Icons.phone,
                      isPassword: false,
                      isEmail: false,
                      isNumber: true,
                      isName: false,
                    ),
                    TextForm(
                      label: 'Address',
                      controller: _addressController,
                      icon: Icons.home,
                      isPassword: false,
                      isEmail: false,
                      isNumber: false,
                      isName: false,
                    ),
                    TextForm(
                      label: 'Email',
                      controller: _emailController,
                      icon: Icons.email,
                      isPassword: false,
                      isEmail: true,
                      isNumber: false,
                      isName: false,
                    ),
                    TextForm(
                      label: 'Password',
                      controller: _passwordController,
                      icon: Icons.lock,
                      isPassword: true,
                      isEmail: false,
                      isNumber: false,
                      isName: false,
                    ),
                    TextForm(
                      label: 'Confirm Password',
                      controller: _confirmPasswordController,
                      icon: Icons.lock,
                      isPassword: true,
                      isEmail: false,
                      isNumber: false,
                      isName: false,
                      confirmPasswordController: _passwordController,
                    ),
                    RegisterButton(
                        formKey: _formKey,
                        authController: _authController,
                        firstNameController: _firstNameController,
                        lastNameController: _lastNameController,
                        phoneController: _phoneController,
                        addressController: _addressController,
                        emailController: _emailController,
                        passwordController: _passwordController),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text("Already have an account? ",style: Theme.of(context).textTheme.labelSmall,),
                  
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                          child:  Text(
                            "Login",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
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
