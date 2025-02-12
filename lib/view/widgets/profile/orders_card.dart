import 'package:final_project/theme/app_color.dart';
import 'package:final_project/view/orders_page.dart';
import 'package:flutter/material.dart';

Widget OrdersCard(BuildContext context, int totalOrders, double totalAmountSpent) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OrdersPage()),
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
            Icon(Icons.shopping_cart, size: 30, color:AppColor.primaryColor),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Orders",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textPrimaryColor,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Total Orders: $totalOrders",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.textSecondaryColor,
                  ),
                ),
                Text(
                  "Total Amount Spent: \$${totalAmountSpent.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.textSecondaryColor,
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, size: 20, color: AppColor.primaryColor),
          ],
        ),
      ),
    ),
  );
}