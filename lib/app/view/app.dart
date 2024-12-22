import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/trades/domain/usecase/trades_use_case.dart';
import 'package:flutter_clean_architecture/features/welcome/presentation/splash/splash_screen_screen_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import '../../core/core_export.dart';
import '../../features/authentication/domain/usecase/auth_use_case.dart';
import '../../features/authentication/presentation/login/bloc/login_bloc_cubit.dart';
import '../../features/authentication/presentation/registration/bloc/registration_bloc.dart';
import '../../features/feature_screen_export.dart';
import '../../features/trades/domain/repo/trade_repository.dart';
import '../../features/trades/presentation/bloc/trades_bloc.dart';
import '../../features/welcome/domain/usecase/welecome_usecase.dart';
import '../../res/res_export.dart';
import '../../services/navigation/navigation_service.dart';

class AppBlocProvider extends StatefulWidget {
  const AppBlocProvider({Key? key}) : super(key: key);

  @override
  State<AppBlocProvider> createState() => _AppBlocProviderState();
}

class _AppBlocProviderState extends State<AppBlocProvider> {
  Locale? _locale;

  @override
  Widget build(BuildContext context) {
    _locale = const Locale("en");

    return GetMaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      onGenerateRoute: AppRouter.generateRoute,
      locale: _locale,
      initialBinding: AppBindings(),

      supportedLocales: const [
        Locale("en"),
        Locale("bn"),
      ],
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocal in supportedLocales) {
          if (supportedLocal.languageCode == locale?.languageCode && supportedLocal.countryCode == locale?.countryCode) {
            return supportedLocal;
          }
        }
        return supportedLocales.first;
      },
      title: context.resources.strings?.appName ?? "Flutter Demo App",
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
      ),
      home: const SplashScreen(),
    );
  }
}


class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Dependency injection using Get.put or Get.lazyPut
    Get.put(AuthUseCase(serviceLocator()));
    Get.put(WelcomeUseCase(serviceLocator()));
    Get.put(TradeUseCase(serviceLocator()));

    // Controllers
    // Get.put(SplashScreenScreenController());
    // Get.put(LoginController(Get.find<AuthUseCase>()));
    // Get.put(RegistrationController(Get.find<AuthUseCase>()));
    // Get.put(TradesController(Get.find<TradeUseCase>()));
  }
}
