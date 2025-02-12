import 'package:final_project/model/user_model.dart';
import 'package:final_project/theme/app_color.dart';
import 'package:flutter/material.dart';

class WelcomeCustomCard extends StatelessWidget {
  const WelcomeCustomCard({
    super.key,
    required UserModel? user,
  }) : _user = user;

  final UserModel? _user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all( 20),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(20)
            ),
            height: 200,
            width: double.infinity,
          ),
          Positioned(
            top: -40,
            right: -50,
            child: 
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColor.primaryColorDark,
                borderRadius: BorderRadius.circular(200)
              ),
              height: 200,
              width: 200,
            ),
          ),
          Positioned(
            top: -20,
            right: -20,
            child: 
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColor.primaryColorLight,
                borderRadius: BorderRadius.circular(100)
              ),
              height: 100,
              width: 100,
            ),
          ),
    
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('Welcome', style: Theme.of(context).textTheme.displayLarge),
                SizedBox(height: 10),
                Text('${_user?.firstName} ${_user?.lastName}', style: Theme.of(context).textTheme.displayLarge),
                SizedBox(height: 20),
                Text('Explore our latest\ncollections and exclusive offers!', style: Theme.of(context).textTheme.displayMedium),
              ],
            ),
          )
    
          
        ],
      ),
    );
  }
}