import 'package:get/get.dart';

import 'package:ongkir/app/modules/home/bindings/home_binding.dart';
import 'package:ongkir/app/modules/home/views/home_view.dart';
import 'package:ongkir/app/modules/splash/bindings/splash_binding.dart';
import 'package:ongkir/app/modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
  ];
}
