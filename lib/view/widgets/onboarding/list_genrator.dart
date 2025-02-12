import 'package:final_project/controller/onboarding_controller.dart';
import 'package:flutter/material.dart';

Widget buildDot(OnboardingController controller,int index, BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.only(right: 5),
      height: 8,
      width: controller.currentIndex == index ? 16 : 8,
      decoration: BoxDecoration(
        color: controller.currentIndex == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

