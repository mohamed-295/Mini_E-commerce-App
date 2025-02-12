import 'package:final_project/view/widgets/profile/contact_us_card.dart';
import 'package:final_project/view/widgets/profile/orders_card.dart';
import 'package:final_project/view/widgets/profile/profile_card.dart';
import 'package:final_project/view/widgets/profile/profile_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:final_project/theme/app_color.dart';
import 'package:final_project/view/widgets/custom_app_bar.dart';
import 'package:final_project/model/user_model.dart';
import 'package:final_project/controller/profile_controller.dart';
import 'package:final_project/service/api_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = ProfileController(ApiService());

    return Scaffold(
      backgroundColor: AppColor.secondaryBackgroundColor,
      appBar: CustomAppBar(title: 'Profile', isLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
              SizedBox(height: 30),
              FutureBuilder(
              future: Future.wait([
                profileController.getUserDetails(),
              ]),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ProfileShimmer();
                } else if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text('Please login to view profile'));
                } else {
                    final user = snapshot.data![0] as UserModel;
            
                  return  ProfileCard(user, context);
        
                }
              },
            ),
            SizedBox(height: 30),
            FutureBuilder(
              future: Future.wait([
                profileController.getUserDetails(),
                profileController.getTotalOrders(),
                profileController.getTotalAmountSpent(),
              ]),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ProfileShimmer();
                } else if (snapshot.hasError) {
                  return OrdersCard(context, 0, 0);
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text('No data available'));
                } else {
                  final totalOrders = snapshot.data![1] as int;
                  final totalAmountSpent = snapshot.data![2] as double;
            
                  return OrdersCard(context, totalOrders, totalAmountSpent);
                }
              },
            ),
            SizedBox(height: 30),
            ContactUsCard(context),
          ],
        ),
      ),
    );
  }
}