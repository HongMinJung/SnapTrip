import 'package:flutter/material.dart';
import 'package:snap_trip/core/theme/app_theme.dart';
import 'package:snap_trip/core/widgets/empty_view.dart';

class NotificationsTab extends StatefulWidget {
  const NotificationsTab({super.key});

  @override
  State<NotificationsTab> createState() => _NotificationsTabState();
}

class _NotificationsTabState extends State<NotificationsTab> {
  // 임시 데이터
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'type': 'trip_invite',
      'title': '여행 초대',
      'message': '홍길동님이 "제주도 여행" 그룹에 초대했습니다.',
      'time': DateTime.now().subtract(const Duration(hours: 2)),
      'isRead': false,
    },
    {
      'id': '2',
      'type': 'trip_reminder',
      'title': '여행 알림',
      'message': '"부산 여행"이 3일 후에 시작됩니다.',
      'time': DateTime.now().subtract(const Duration(hours: 12)),
      'isRead': true,
    },
    {
      'id': '3',
      'type': 'new_message',
      'title': '새 메시지',
      'message': '김철수님이 "서울 당일치기" 그룹에 메시지를 보냈습니다.',
      'time': DateTime.now().subtract(const Duration(days: 1)),
      'isRead': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // 앱 바
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  '알림',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    // 모든 알림 삭제 확인 다이얼로그
                    _showDeleteConfirmationDialog();
                  },
                ),
              ],
            ),
          ),

          // 알림 목록
          Expanded(
            child: _notifications.isEmpty
                ? const EmptyView(
                    title: '알림이 없습니다',
                    message: '새로운 알림이 도착하면 여기에 표시됩니다',
                    icon: Icons.notifications_none,
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _notifications.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final notification = _notifications[index];
                      return _buildNotificationItem(notification);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    final IconData icon;
    final Color iconColor;

    // 알림 타입에 따른 아이콘 설정
    switch (notification['type']) {
      case 'trip_invite':
        icon = Icons.group_add;
        iconColor = Colors.blue;
        break;
      case 'trip_reminder':
        icon = Icons.event;
        iconColor = Colors.orange;
        break;
      case 'new_message':
        icon = Icons.message;
        iconColor = Colors.green;
        break;
      default:
        icon = Icons.notifications;
        iconColor = AppColors.primary;
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: iconColor.withOpacity(0.2),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      title: Text(
        notification['title'],
        style: TextStyle(
          fontWeight:
              notification['isRead'] ? FontWeight.normal : FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(notification['message']),
          const SizedBox(height: 4),
          Text(
            _formatTime(notification['time']),
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
      trailing: notification['isRead']
          ? null
          : Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
            ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      onTap: () {
        // 알림 읽음 처리 및 관련 화면으로 이동
        setState(() {
          notification['isRead'] = true;
        });

        // 알림 타입에 따른 화면 이동
        switch (notification['type']) {
          case 'trip_invite':
            // 여행 초대 화면으로 이동
            break;
          case 'trip_reminder':
            // 해당 여행 상세 화면으로 이동
            break;
          case 'new_message':
            // 그룹 채팅 화면으로 이동
            break;
        }
      },
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inSeconds < 60) {
      return '방금 전';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else {
      return '${time.year}.${time.month}.${time.day}';
    }
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('알림 삭제'),
        content: const Text('모든 알림을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _notifications.clear();
              });
              Navigator.of(context).pop();
            },
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }
}
