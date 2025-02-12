import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:final_project/controller/cart_controller.dart';
import 'package:final_project/controller/category_controller.dart';
import 'package:final_project/controller/product_controller.dart';
import 'package:final_project/service/api_service.dart';
import 'package:final_project/service/connectivity_service.dart';
import 'package:final_project/service/navigation_service.dart';
import 'package:final_project/theme/text_theme.dart';
import 'package:final_project/view/no_connection_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ConnectivityService connectivityService = ConnectivityService();

    return StreamBuilder<ConnectivityResult>(
      stream: connectivityService.connectivityStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data == ConnectivityResult.none) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter App',
            theme: ThemeData(
              textTheme: CustomTextTheme.textTheme,
            ),
            home: NoConnectionPage(),
          );
        }

        return MultiProvider(
          providers: [
                    ChangeNotifierProvider(create: (_) => CartController(ApiService())),

            ChangeNotifierProvider(
                create: (_) =>
                    CategoryController(ApiService())),
            ChangeNotifierProvider(
                create: (_) =>
                    ProductController(ApiService())),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter App',
            theme: ThemeData(
              textTheme: CustomTextTheme.textTheme,
            ),
            home: NavigationServiceWidget(),
          ),
        );
      },
    );
  }
}