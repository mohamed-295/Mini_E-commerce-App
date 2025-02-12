class OnboardingModel {

  final String title;
  final String description;
  final String image;

  OnboardingModel({

    required this.title,
    required this.description,
    required this.image,
  });
}

List<OnboardingModel> onboardingData = [
  OnboardingModel(
  
    title: "Purchase Online",
    description: "Discover new opportunities and stay connected.",
    image: "assets/images/onboarding1.jpg",
  ),
  OnboardingModel(
    
    title: "Track order",
    description: "Manage your tasks efficiently with our tools.",
    image: "assets/images/onboarding2.jpg",
  ),
  OnboardingModel(
  
    title: "Get your order",
    description: "Sign up and start your journey today.",
    image: "assets/images/onboarding3.jpg",
  ),
];
