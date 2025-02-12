import 'package:final_project/view/order_details_page.dart';
import 'package:final_project/view/widgets/custom_app_bar.dart';
import 'package:final_project/view/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:final_project/controller/profile_controller.dart';
import 'package:final_project/model/order_model.dart';
import 'package:final_project/service/api_service.dart';
import 'package:final_project/theme/app_color.dart';
import 'package:shimmer/shimmer.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = ProfileController(ApiService());

    return Scaffold(
      appBar:CustomAppBar(title: 'Orders'),
      backgroundColor: AppColor.secondaryBackgroundColor,
      body: FutureBuilder<List<Order>>(
        future: profileController.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              itemCount: 12,
              itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ShimmerWidget.rectangular(width: double.infinity, height: 80),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('No orders available 🛒', style: Theme.of(context).textTheme.titleLarge));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No orders available 🛒', style:Theme.of(context).textTheme.titleLarge));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final order = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(order.image, width: 60, height: 60, fit: BoxFit.cover),
                    ),
                    title: Text(order.name, style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.primaryColorDark)),
                    subtitle: Text('Total: \$${order.total.toStringAsFixed(2)}', style: TextStyle(color: AppColor.textSecondaryColor)),
                    trailing: Icon(Icons.arrow_forward_ios, color: AppColor.primaryColor),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderDetailsPage(order: order)),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
