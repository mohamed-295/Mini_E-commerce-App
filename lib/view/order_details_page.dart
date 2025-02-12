import 'package:final_project/theme/app_color.dart';
import 'package:final_project/view/product_details_page.dart';
import 'package:final_project/view/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:final_project/model/order_model.dart';
import 'package:intl/intl.dart';

class OrderDetailsPage extends StatelessWidget {
  final Order order;
  const OrderDetailsPage({super.key, required this.order});

  String _formatOrderDate(DateTime date) {
    DateTime localDate = date.toLocal().add(Duration(hours: 2)); 
    final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm a');
    return formatter.format(localDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Order Details'),
      backgroundColor: AppColor.secondaryBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColor.primaryColorDark, width: 4),
                  color: AppColor.secondaryBackgroundColor,
                ),
                child: Card(
                  borderOnForeground: true,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(order.image),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(order.name,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColorDark)),
              SizedBox(height: 8),
              Text(order.description,
                  style: TextStyle(
                      fontSize: 16, color: AppColor.textSecondaryColor)),
              SizedBox(height: 8),
              Text('Price: \$${order.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16, color: AppColor.primaryColor)),
              SizedBox(height: 8),
              Text('Quantity: ${order.quantity}',
                  style: TextStyle(fontSize: 16, color: AppColor.primaryColor)),
              SizedBox(height: 16),
              Text('Total: \$${order.total.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColorDark)),
              SizedBox(height: 16),
              Text(
                'Ordered on: ${_formatOrderDate(order.createdAt)}',
                style: TextStyle(fontSize: 16, color: AppColor.textSecondaryColor),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.secondaryColorDark,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(
                              productId: order.productId, title: order.name)),
                    );
                  },
                  child: Text('View Product',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
