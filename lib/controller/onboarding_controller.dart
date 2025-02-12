import 'package:final_project/model/onboarding_model.dart';
import 'package:final_project/service/cashe_service.dart';
import 'package:final_project/view/login_page.dart';
import 'package:final_project/view/register_page.dart';
import 'package:flutter/material.dart';

class OnboardingController {
  PageController pageController = PageController();
  int currentIndex = 0;

  List<OnboardingModel> getOnboardingData() {
    return onboardingData;
  }

  void nextPage(BuildContext context) {
    if (currentIndex < onboardingData.length - 1) {
      currentIndex++;
      pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      CasheService.setOnboardingCompleted();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  void updateIndex(int index) {
    currentIndex = index;
  }

  void login(BuildContext context) {
    CasheService.setOnboardingCompleted();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void signUp(BuildContext context) {
    CasheService.setOnboardingCompleted();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterPage()));
  }
}