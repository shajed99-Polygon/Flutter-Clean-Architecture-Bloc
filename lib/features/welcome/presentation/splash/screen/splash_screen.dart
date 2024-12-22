import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/core_export.dart';
import 'package:flutter_clean_architecture/features/welcome/presentation/splash/splash_screen_screen_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(SplashScreenScreenController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            height: double.infinity,
            color: context.resources.color.white,
            child: SvgPicture.asset(context.resources.drawable.splashImage),
          ),
          const Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
