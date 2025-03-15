import 'package:flutter/material.dart';
import 'package:snap_trip/presentation/screens/auth/forgot_password_screen.dart';
import 'package:snap_trip/presentation/screens/auth/splash_screen.dart';
import 'package:snap_trip/presentation/screens/auth/login_screen.dart';
import 'package:snap_trip/presentation/screens/auth/register_screen.dart';
import 'package:snap_trip/presentation/screens/home/home_screen.dart';
// 필요한 다른 화면들 import

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String tripDetails = '/trip-details';
  static const String createTrip = '/create-trip';
  static const String placeDetails = '/place-details';
  static const String mapView = '/map-view';
  static const String settings = '/settings';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      // 다른 화면들도 필요에 따라 추가
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('정의되지 않은 경로: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
