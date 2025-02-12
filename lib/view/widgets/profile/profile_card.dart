 import 'package:final_project/model/user_model.dart';
import 'package:final_project/service/cashe_service.dart';
import 'package:final_project/theme/app_color.dart';
import 'package:final_project/view/login_page.dart';
import 'package:flutter/material.dart';

Widget ProfileCard(UserModel user, BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: AppColor.secondaryColor,
            child: Icon(Icons.person, size: 30, color: Colors.white),
          ),
          title: Text(
            '${user.firstName} ${user.lastName}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Email: ${user.email}", style: TextStyle(fontSize: 14, color: AppColor.textSecondaryColor)),
              SizedBox(height: 5),
              Text("Phone: ${user.phone}", style: TextStyle(fontSize: 14, color: AppColor.textSecondaryColor)),
            ],
          ),
          contentPadding: const EdgeInsets.all(5),
          trailing: IconButton(
            icon: const Icon(Icons.logout_outlined, color: Colors.red, size: 30),
            onPressed: () {
              CasheService.setUserLoggedOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ),
      ),
    );
  }