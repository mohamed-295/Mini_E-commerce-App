import 'package:final_project/theme/app_color.dart';
import 'package:final_project/view/contact_us_page.dart';
import 'package:flutter/material.dart';

Widget ContactUsCard(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ContactUsPage()),
      );
    },
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.contact_mail, size: 30, color: AppColor.primaryColor),
            SizedBox(width: 15),
            Text(
              "Contact Us",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColor.textPrimaryColor,
              ),
            ),
             Spacer(),
            Icon(Icons.arrow_forward_ios, size: 20, color: AppColor.primaryColor),
          ],
        ),
      ),
    ),
  );
}