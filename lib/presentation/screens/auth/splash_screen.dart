import 'package:flutter/material.dart';
import 'package:snap_trip/routes/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  Future<void> _navigateToLogin() async {
    // 로고를 보여주기 위해 잠시 지연
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Supabase 인증 확인 과정 생략하고 직접 로그인 화면으로 이동
    print('로그인 화면으로 이동 시도');
    try {
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      print('로그인 화면으로 이동 완료');
    } catch (e) {
      print('로그인 화면 이동 오류: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 앱 로고
              const Icon(
                Icons.travel_explore,
                size: 100,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              // 앱 이름
              const Text(
                'SnapTrip',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 40),
              // 로딩 인디케이터
              const CircularProgressIndicator(
                color: Colors.blue,
              ),
              const SizedBox(height: 40),
              // 디버깅용 텍스트
              const Text(
                '화면 전환 중...',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
