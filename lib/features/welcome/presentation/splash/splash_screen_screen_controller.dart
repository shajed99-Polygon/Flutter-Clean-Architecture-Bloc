import 'package:flutter_clean_architecture/features/welcome/domain/usecase/welecome_usecase.dart';
import 'package:flutter_clean_architecture/res/routes/route_paths.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SplashScreenScreenController extends GetxController {
  final WelcomeUseCase welcomeUseCase = Get.find();

  SplashScreenScreenController() {
    initApp();
  }

  Future<void> initApp() async {
    await Future.delayed(const Duration(seconds: 2));
    bool login = await welcomeUseCase.isUserLoggedIn();

    if (login) {
      Get.offAllNamed(RoutePaths.tradeScreen);
    } else {
      Get.offAllNamed(RoutePaths.loginScreen);
    }
  }
}
