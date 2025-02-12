import 'package:final_project/model/user_model.dart';
import 'package:final_project/service/api_service.dart';
import 'package:final_project/service/cashe_service.dart';
import 'package:flutter/material.dart';

class AuthController {
  final ApiService apiService;

  AuthController(this.apiService);

  Future<UserModel> register(BuildContext context, Map<String, dynamic> data) async {
    try {
      final response = await apiService.postData('register', data);
      return UserModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await apiService.postData('login', {'email': email, 'password': password});
      final UserModel user = UserModel.fromJson(response);
      await CasheService.setUserLoggedIn(user.token, user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout(String token) async {
    try {
      await apiService.postData('logout', {}, token: token);
      await CasheService.setUserLoggedOut();
    } catch (e) {
      rethrow;
    }
  }
}