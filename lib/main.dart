import 'package:flutter/material.dart';
import 'package:snap_trip/core/config/supabase_config.dart';
import 'package:snap_trip/core/theme/app_theme.dart';
import 'package:snap_trip/presentation/screens/auth/forgot_password_screen.dart';
import 'package:snap_trip/presentation/screens/auth/register_screen.dart';
import 'package:snap_trip/presentation/screens/home/home_screen.dart';
import 'package:snap_trip/presentation/screens/auth/login_screen.dart';
import 'package:snap_trip/routes/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Supabase 초기화
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
    debug: true, // 개발 중에는 디버그 활성화
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnapTrip',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.home,
      // initialRoute: AppRoutes.login,
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/create-trip': (context) => const Scaffold(
              body: Center(child: Text('여행 추가 화면')),
            ),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/register': (context) => const RegisterScreen(),
        // 기타 필요한 경로 추가
      },
      // 정의되지 않은 경로에 대한 처리
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('오류')),
            body: Center(
              child: Text('경로를 찾을 수 없습니다: ${settings.name}'),
            ),
          ),
        );
      },
    );
  }
}
