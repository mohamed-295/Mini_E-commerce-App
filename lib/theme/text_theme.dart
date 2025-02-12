import 'package:flutter/material.dart';
import 'app_color.dart';

class CustomTextTheme {

  static TextTheme get textTheme {
    return TextTheme(

      headlineLarge: TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColor.textPrimaryColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColor.textPrimaryColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColor.textPrimaryColor,
      ),


      titleLarge: TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColor.primaryColorDark,
      ),
      titleMedium: TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColor.primaryColorDark,
      ),
      titleSmall: TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColor.primaryColorDark,
      ),



      bodyLarge: TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColor.secondaryColorDark,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColor.secondaryColorDark,
      ),
      bodySmall: TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColor.secondaryColorDark,
      ),


      labelLarge: TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColor.textSecondaryColor,
      ),
      labelMedium: TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColor.textSecondaryColor,
      ),
      labelSmall: TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColor.textSecondaryColor,
      ),

       displayLarge: TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColor.textLightColor,
      ),
      displayMedium: TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColor.textLightColor,
      ),
      displaySmall: TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColor.textLightColor,
      ),



  
     
    );
  }
}