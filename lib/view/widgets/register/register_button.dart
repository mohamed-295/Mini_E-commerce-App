import 'package:final_project/controller/auth_controller.dart';
import 'package:final_project/theme/app_color.dart';
import 'package:final_project/view/login_page.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final AuthController authController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const RegisterButton({
    super.key,
    required this.formKey,
    required this.authController,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.addressController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          try {
            await authController.register(context, {
              'first_name': firstNameController.text,
              'last_name': lastNameController.text,
              'phone': phoneController.text,
              'address': addressController.text,
              'email': emailController.text,
              'password': passwordController.text,
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Account created successfully'),
                backgroundColor: AppColor.successColor,
              ),
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(e.toString()), backgroundColor: AppColor.errorColorDark),
            );
          }
        }
      },
      child: Text('Sign Up', style: Theme.of(context).textTheme.displayLarge),
    );
  }
}
