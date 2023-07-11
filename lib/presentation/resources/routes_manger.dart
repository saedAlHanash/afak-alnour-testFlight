
import 'package:get/get.dart';

import '../about_us/view/about_us_view.dart';
import '../about_us/view_model/about_us_binding.dart';
import '../edit_profile/view/edit_profile_view.dart';
import '../edit_profile/view_model/edit_profile_binding.dart';
import '../login/view/login_view.dart';
import '../login/view_model/login_binding.dart';
import '../main/main_view/main_view.dart';
import '../main/main_view_model/main_binding.dart';
import '../main/pages/home_page/view/home_view.dart';
import '../main/pages/home_page/view_model/home_binding.dart';
import '../main/pages/profile_page/view/profile_view.dart';
import '../main/pages/profile_page/view_model/profile_binding.dart';
import '../main/pages/set_my_available_page/view/set_my_available_view.dart';
import '../main/pages/set_my_available_page/view_model/set_my_availabel_binding.dart';
import '../on_boarding/view/on_boarding_view.dart';
import '../on_boarding/view_model/on_boarding_binding.dart';
import '../register/view/register_view.dart';
import '../register/view_model/register_binding.dart';
import '../splash/view/splash_view.dart';

class Routes {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String mainRoute = '/main';
  static const String onBoardingRoute = '/onBoarding';
  static const String registerRoute = '/register';
  static const String profileRoute = '/profile';
  static const String homeRoute = '/home';
  static const String setMyAvailableRoute = '/set';
  static const String editProfileRoute = '/editProfile';
  static const String aboutUsRoute = '/aboutUs';
}

List<GetPage> pages = [
  GetPage(
    name: Routes.splashRoute,
    page: () => const SplashScreen(),
  ),
  GetPage(
      name: Routes.onBoardingRoute,
      page: () => const OnBoardingScreen(),
      binding: OnBoardingBinding()),
  GetPage(
      name: Routes.loginRoute,
      page: () =>  LoginScreen(),
      binding: LoginBinding()),
  GetPage(
      name: Routes.registerRoute,
      page: () => RegisterScreen(),
      binding: RegisterBinding()),
  GetPage(
      name: Routes.mainRoute, page: () => const MainScreen(), binding: MainBinding()),
  GetPage(
      name: Routes.profileRoute,
      page: () =>  const ProfileView(),
      binding: ProfileBinding()),
  GetPage(
      name: Routes.homeRoute,
      page: () => const HomeView(),
      binding: HomeBinding()),
  GetPage(
      name: Routes.setMyAvailableRoute,
      page: () => SetMyAvailableView(),
      binding: SetMyAvailableBinding()),
  GetPage(
      name: Routes.editProfileRoute,
      page: () => const EditProfileView(),
      binding: EditProfileBinding()),
  GetPage(
      name: Routes.aboutUsRoute,
      page: () => const AboutUsView(),
      binding: AboutUsBinding()),
];
