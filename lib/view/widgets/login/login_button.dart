import 'package:final_project/theme/app_color.dart';
import 'package:final_project/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:final_project/controller/auth_controller.dart';

class LoginButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final AuthController authController;

  const LoginButton({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.authController,
  });

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF037EE6),
       padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10),
        textStyle:Theme.of(context).textTheme.labelLarge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: _isLoading ? null : () async {
        if (widget.formKey.currentState!.validate()) {
          setState(() {
            _isLoading = true;
          });
          try {
             await widget.authController.login(
              widget.emailController.text,
              widget.passwordController.text,
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Login successful'),
               backgroundColor:  AppColor.successColor,
              ),
            );
                    } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$e'),
                backgroundColor: AppColor.errorColorDark,
              ),
            );
          } finally {
            setState(() {
              _isLoading = false;
            });
          }
        }
      },
      child: _isLoading
          ? const CircularProgressIndicator(color: Colors.black, strokeWidth: 2)
          : const Text('Login'),
    );
  }
}