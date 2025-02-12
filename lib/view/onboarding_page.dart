import 'package:final_project/controller/onboarding_controller.dart';
import 'package:final_project/model/onboarding_model.dart';
import 'package:final_project/theme/app_color.dart';
import 'package:final_project/view/widgets/onboarding/custom_button.dart';
import 'package:final_project/view/widgets/onboarding/list_genrator.dart';
import 'package:final_project/view/widgets/onboarding/onboarding_content.dart';
import 'package:flutter/material.dart';


class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final OnboardingController controller = OnboardingController();
  late List<OnboardingModel> onboardingItems;

  @override
  void initState() {
    super.initState();
    onboardingItems = controller.getOnboardingData(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: (index) {
                setState(() {
                  controller.updateIndex(index);
                });
              },
              itemCount: onboardingItems.length,
              itemBuilder: (context, index) => OnboardingContent(
                title: onboardingItems[index].title,
                description: onboardingItems[index].description,
                image: onboardingItems[index].image,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingItems.length,
                      (index) => buildDot(controller,index, context),
                    ),
                  ),
                ),
                CustomButton(controller: controller, onboardingItems: onboardingItems),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
