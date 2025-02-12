import 'package:final_project/theme/app_color.dart';
import 'package:final_project/view/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:final_project/view/widgets/text_form.dart';

class ContactUsPage extends StatelessWidget {
  ContactUsPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryBackgroundColor,
      appBar: CustomAppBar(title: 'Contact Us', isLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextForm(
                label: 'Full Name',
                controller: _nameController,
                icon: Icons.person,
                isPassword: false,
                isEmail: false,
                isNumber: false,
                isName: true,
              ),
              const SizedBox(height: 16),
              TextForm(
                label: 'Email',
                controller: _emailController,
                icon: Icons.email,
                isPassword: false,
                isEmail: true,
                isNumber: false,
                isName: false,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Message :',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _messageController,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white70,
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Message is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.secondaryColorDark,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _nameController.clear();
                    _emailController.clear();
                    _messageController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Message sent successfully',
                          textAlign: TextAlign.center),
                      backgroundColor: AppColor.successColor,
                    ));
                  }
                },
                child: Text('Submit', style: Theme.of(context).textTheme.displayLarge),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
