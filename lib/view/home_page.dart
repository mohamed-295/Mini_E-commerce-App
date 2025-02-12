import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:final_project/controller/home_controller.dart';
import 'package:final_project/model/user_model.dart';
import 'package:final_project/service/cashe_service.dart';
import 'package:final_project/theme/app_color.dart';
import 'package:final_project/view/cart_page.dart';
import 'package:final_project/view/category_page.dart';
import 'package:final_project/view/no_connection_page.dart';
import 'package:final_project/view/profile_page.dart';
import 'package:final_project/view/widgets/home/categories_widget.dart';
import 'package:final_project/view/widgets/home/new_arrival_widget.dart';
import 'package:final_project/view/widgets/home/products_widget.dart';
import 'package:final_project/view/widgets/home/search_widget.dart';
import 'package:final_project/view/widgets/home/welcome_custom_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel? _user;
  bool _isNavigatedToNoConnectionPage = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    UserModel? user = await CasheService.getUser();
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    final iconList = <IconData>[
      Icons.home,
      Icons.category,
      Icons.shopping_cart,
      Icons.person,
    ];

    return ChangeNotifierProvider(
      create: (_) => HomeController(),
      child: Consumer<HomeController>(
        builder: (context, homeController, child) {
          return StreamBuilder<ConnectivityResult>(
            stream: homeController.connectivityStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == ConnectivityResult.none && !_isNavigatedToNoConnectionPage) {
                _isNavigatedToNoConnectionPage = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => NoConnectionPage()),
                  );
                });
              }

              Widget getPage(int index) {
                switch (index) {
                  case 0:
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        SearchWidget(),
                        WelcomeCustomCard(user: _user),
                        CategoriesWidget(),
                        NewArrivalWidget(),
                        ProductsWidget(),
                      ],
                    );
                  case 1:
                    return CategoryPage(isLeading: false);
                  case 2:
                    return CartPage();
                  case 3:
                    return ProfilePage();
                  default:
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        SearchWidget(),
                        WelcomeCustomCard(user: _user),
                        CategoriesWidget(),
                        NewArrivalWidget(),
                        ProductsWidget(),
                      ],
                    );
                }
              }

              return Scaffold(
                backgroundColor: AppColor.secondaryBackgroundColor,
                body: getPage(homeController.currentIndex),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: AnimatedBottomNavigationBar(
                    icons: iconList,
                    borderColor: AppColor.primaryColorLight,
                    borderWidth: 4,
                    activeIndex: homeController.currentIndex,
                    gapLocation: GapLocation.center,
                    notchSmoothness: NotchSmoothness.softEdge,
                    onTap: (index) => homeController.setIndex(index),
                    activeColor: AppColor.primaryColor,
                    inactiveColor: AppColor.textSecondaryColor,
                    backgroundColor: AppColor.secondaryBackgroundColor,
                    height: 50,
                    elevation: 10,
                    iconSize: 25,
                    leftCornerRadius: 32,
                    rightCornerRadius: 32,
                    
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}