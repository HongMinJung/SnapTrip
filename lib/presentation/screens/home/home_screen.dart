import 'package:flutter/material.dart';
import 'package:snap_trip/core/theme/app_theme.dart';
import 'package:snap_trip/presentation/screens/home/explore_tab.dart';
import 'package:snap_trip/presentation/screens/home/my_trips_tab.dart';
import 'package:snap_trip/presentation/screens/home/notifications_tab.dart';
import 'package:snap_trip/presentation/screens/home/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const ExploreTab(),
    const MyTripsTab(),
    const NotificationsTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      floatingActionButton: _currentIndex == 1
          ? FloatingActionButton(
              onPressed: () {
                // 여행 추가 화면으로 이동
                Navigator.of(context).pushNamed('/create-trip');
              },
              backgroundColor: AppColors.primary, // 플로팅 버튼 배경색을 오렌지로 변경
              child: const Icon(
                Icons.add,
                color: Colors.white, // 아이콘 색상을 흰색으로 설정
              ),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppColors.primary, // 선택된 아이템 색상을 오렌지로 변경
        unselectedItemColor: AppColors.textSecondary, // 선택되지 않은 아이템 색상을 회색으로 변경
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: '둘러보기',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel),
            label: '내 여행',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '알림',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}
