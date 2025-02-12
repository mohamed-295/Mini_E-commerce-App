import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:final_project/view/home_page.dart';
import 'package:final_project/view/login_page.dart';
import 'package:final_project/view/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:final_project/service/cashe_service.dart';
import 'package:final_project/view/no_connection_page.dart';

class NavigationServiceWidget extends StatefulWidget {
  const NavigationServiceWidget({super.key});

  @override
  _NavigationServiceWidgetState createState() => _NavigationServiceWidgetState();
}

class _NavigationServiceWidgetState extends State<NavigationServiceWidget> {
  late Future<String> initialRouteFuture;

  @override
  void initState() {
    super.initState();
    initialRouteFuture = getInitialRoute();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: initialRouteFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (snapshot.data == "no_connection") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NoConnectionPage()),
              );
            } else if (snapshot.data == "home") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            } else if (snapshot.data == "login") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => OnboardingPage()),
              );
            }
          });
          return Container();
        }
      },
    );
  }

  Future<String> getInitialRoute() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.toString() == "[ConnectivityResult.none]") {
      return "no_connection";
    }

    bool isOnboardingCompleted = await CasheService.isOnboardingCompleted();
    bool isLoggedIn = await CasheService.isUserLoggedIn();

    if (isLoggedIn) {
      return "home";
    } else if (isOnboardingCompleted) {
      return "login";
    } else {
      return "onboarding";
    }
  }
}