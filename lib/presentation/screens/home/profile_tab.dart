import 'package:flutter/material.dart';
import 'package:snap_trip/core/theme/app_theme.dart';
import 'package:snap_trip/core/widgets/loading_indicator.dart';
import 'package:snap_trip/data/services/auth_service.dart';
import 'package:snap_trip/routes/app_router.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final _authService = AuthService();
  bool _isLoading = false;

  // 임시 사용자 데이터
  final Map<String, dynamic> _userData = {
    'username': 'traveler123',
    'fullName': '홍길동',
    'email': 'user@example.com',
    'bio': '여행을 사랑하는 탐험가입니다. 새로운 장소를 발견하고 추억을 만드는 것을 좋아합니다.',
    'avatarUrl': 'https://randomuser.me/api/portraits/men/32.jpg',
    'tripCount': 5,
    'reviewCount': 12,
    'favoriteCount': 8,
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _isLoading
          ? const LoadingIndicator()
          : SingleChildScrollView(
              child: Column(
                children: [
                  // 프로필 헤더
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        // 프로필 이미지 및 편집 버튼
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  NetworkImage(_userData['avatarUrl']),
                              backgroundColor: Colors.grey[300],
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: AppColors.primary,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  onPressed: () {
                                    // 프로필 편집 화면으로 이동
                                    Navigator.of(context)
                                        .pushNamed('/edit-profile');
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // 사용자 이름
                        Text(
                          _userData['fullName'],
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(height: 4),

                        // 사용자 ID
                        Text(
                          '@${_userData['username']}',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                        ),
                        const SizedBox(height: 16),

                        // 사용자 소개
                        Text(
                          _userData['bio'],
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 20),

                        // 통계 카드
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStatCard(
                              context,
                              _userData['tripCount'].toString(),
                              '여행',
                              Icons.card_travel,
                            ),
                            _buildStatCard(
                              context,
                              _userData['reviewCount'].toString(),
                              '리뷰',
                              Icons.rate_review,
                            ),
                            _buildStatCard(
                              context,
                              _userData['favoriteCount'].toString(),
                              '저장',
                              Icons.favorite,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // 메뉴 항목들
                  const SizedBox(height: 20),
                  _buildMenuItem(
                    context,
                    title: '계정 정보',
                    icon: Icons.person,
                    onTap: () {
                      Navigator.of(context).pushNamed('/account-settings');
                    },
                  ),
                  _buildMenuItem(
                    context,
                    title: '저장된 장소',
                    icon: Icons.bookmark,
                    onTap: () {
                      Navigator.of(context).pushNamed('/saved-places');
                    },
                  ),
                  _buildMenuItem(
                    context,
                    title: '알림 설정',
                    icon: Icons.notifications,
                    onTap: () {
                      Navigator.of(context).pushNamed('/notification-settings');
                    },
                  ),
                  _buildMenuItem(
                    context,
                    title: '언어 설정',
                    icon: Icons.language,
                    onTap: () {
                      Navigator.of(context).pushNamed('/language-settings');
                    },
                  ),
                  _buildMenuItem(
                    context,
                    title: '도움말 및 지원',
                    icon: Icons.help,
                    onTap: () {
                      Navigator.of(context).pushNamed('/help-support');
                    },
                  ),
                  _buildMenuItem(
                    context,
                    title: '개인정보 처리방침',
                    icon: Icons.privacy_tip,
                    onTap: () {
                      Navigator.of(context).pushNamed('/privacy-policy');
                    },
                  ),
                  _buildMenuItem(
                    context,
                    title: '로그아웃',
                    icon: Icons.logout,
                    iconColor: AppColors.error,
                    textColor: AppColors.error,
                    onTap: _logout,
                  ),
                  const SizedBox(height: 20),

                  // 앱 버전
                  Text(
                    'SnapTrip v1.0.0',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textLight,
                        ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String count,
    String label,
    IconData icon,
  ) {
    return Container(
      width: 90,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            count,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? AppColors.textSecondary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textLight,
      ),
      onTap: onTap,
    );
  }

  Future<void> _logout() async {
    // 로그아웃 확인 다이얼로그
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그아웃'),
        content: const Text('정말 로그아웃하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();

              try {
                await _authService.signOut();

                if (!mounted) return;

                // 로그인 화면으로 이동하고 이전 스택 제거
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.login,
                  (route) => false,
                );
              } catch (e) {
                if (!mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('로그아웃 오류: $e')),
                );
              }
            },
            child: const Text('로그아웃'),
          ),
        ],
      ),
    );
  }
}
