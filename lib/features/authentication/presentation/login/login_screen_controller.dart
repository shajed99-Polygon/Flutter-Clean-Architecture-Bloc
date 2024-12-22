import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/presentation/widget/snackbar/custom_snackbar.dart';
import 'package:flutter_clean_architecture/features/authentication/domain/usecase/auth_use_case.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  final AuthUseCase authUseCase = Get.find();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login(String username, String password) async {
    var validity = await _checkingValidations(username, password);
    if (!validity) return;

    final result = await authUseCase.doLogin(AuthLoginReq(userName: username, password: password));

    result.fold(
      (failure) => emit(LoginError(failure.message)),
      (user) {
        user ? emit(LoginSuccess()) : emit(const LoginError('Login failed'));
      },
    );
  }

  Future<bool> _checkingValidations() async {
    if (usernameController.text.isEmpty) {
      SnackBarUtils.showError(message: 'Username cannot be empty');
      return false;
    }

    if (passwordController.text.isEmpty) {
      SnackBarUtils.showError(message: 'Password cannot be empty');
      return false;
    }

    return true;
    // else if (password.isEmpty) {
    //   emit(const LoginError('Password cannot be empty'));
    //   return false;
    // } else {
    //   emit(LoginLoading());
    //
    // }
  }
}
