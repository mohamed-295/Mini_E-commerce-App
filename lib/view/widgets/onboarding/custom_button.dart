import 'package:final_project/controller/onboarding_controller.dart';
import 'package:final_project/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final OnboardingController controller;
  final List onboardingItems;
  const CustomButton(
      {super.key, required this.controller, required this.onboardingItems});

  @override
  Widget build(BuildContext context) {
    return controller.currentIndex == onboardingItems.length - 1
        ?Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColor.textLightColor,
                  backgroundColor: AppColor.primaryColor,
                  padding: const EdgeInsets.all(15),
                  minimumSize: Size(100, 50),
                  textStyle: Theme.of(context).textTheme.titleLarge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () => controller.signUp(context),
                child: Text(
                  "Sign Up",
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColor.textLightColor,
                  backgroundColor: AppColor.primaryColor,
                  padding: const EdgeInsets.all(15),
                  minimumSize: Size(100, 50),
                  textStyle: Theme.of(context).textTheme.titleLarge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () => controller.login(context),
                child: Text(
                  "Login",
                ),
              )
            ],
          )
        : Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColor.textLightColor,
                  backgroundColor: AppColor.primaryColor,
                  padding: const EdgeInsets.all(15),
                  minimumSize: Size(120, 25),
                  textStyle: Theme.of(context).textTheme.titleLarge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () => controller.nextPage(context),
                child: Text(
                  "Next",
                ),
              ),
          ],
        ); 
  }
}
