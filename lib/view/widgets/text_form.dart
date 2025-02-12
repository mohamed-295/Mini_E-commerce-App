import 'package:final_project/theme/app_color.dart';
import 'package:flutter/material.dart';

class TextForm extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final bool isPassword;
  final bool isEmail;
  final bool isNumber;
  final bool isName;
  final TextEditingController? confirmPasswordController;

  const TextForm({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    required this.isPassword,
    required this.isEmail,
    required this.isNumber,
    required this.isName,
    this.confirmPasswordController,
  });

  @override
  _TextFormState createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  late bool _isPassword;

  @override
  void initState() {
    super.initState();
    _isPassword = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.controller,
          cursorColor: AppColor.primaryColor,

          decoration: InputDecoration(
            
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColor.primaryColorLight, width: 2),
            ),
            labelText: widget.label,
            labelStyle: Theme.of(context).textTheme.bodyLarge,
            errorStyle: const TextStyle(
                color: AppColor.errorColorDark,
                fontSize: 14,
                fontWeight: FontWeight.w700),
            errorMaxLines: 3,
            prefixIcon: Icon(widget.icon, color: Color(0xFF037EE6),size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.white70,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _isPassword ? Icons.visibility_off : Icons.visibility,
                      color: Color(0xFF037EE6),
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPassword = !_isPassword;
                      });
                    },
                  )
                : null,
          ),
          obscureText: _isPassword,
          keyboardType: widget.isEmail
              ? TextInputType.emailAddress
              : widget.isNumber
                  ? TextInputType.phone
                  : TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '${widget.label} is required';
            }
            if (widget.isName && value.length < 3) {
              return 'Name must be at least 3 characters long';
            }
            if (widget.isEmail &&
                !RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                    .hasMatch(value)) {
              return 'Enter a valid email address';
            }
            if (widget.isPassword && value.length < 6) {
              return 'Password must be at least 6 characters long';
            }
            if (widget.isPassword &&
                !RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                    .hasMatch(value)) {
              return 'Password must contain uppercase, lowercase, number, and special characters';
            }
            if (widget.isNumber && !RegExp(r"^[0-9]{10,}$").hasMatch(value)) {
              return 'Enter a valid phone number';
            }
            if (widget.confirmPasswordController != null &&
                widget.confirmPasswordController!.text != value) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}