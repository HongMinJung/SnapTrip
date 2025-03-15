import 'package:flutter/material.dart';
import 'package:snap_trip/core/theme/app_theme.dart';
import 'package:snap_trip/core/widgets/empty_view.dart';
import 'package:snap_trip/core/widgets/loading_indicator.dart';

class MyTripsTab extends StatefulWidget {
  const MyTripsTab({super.key});

  @override
  State<MyTripsTab> createState() => _MyTripsTabState();
}

class _MyTripsTabState extends State<MyTripsTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;

  // 임시 데이터
  final List<Map<String, dynamic>> _upcomingTrips = [
    {
      'id': '1',
      'title': '제주도 여행',
      'startDate': '2025-05-15',
      'endDate': '2025-05-18',
      'location': '제주특별자치도',
      'image': 'https://images.unsplash.com/photo-1590553866560-9da91a414bab',
    },
  ];

  final List<Map<String, dynamic>> _pastTrips = [
    {
      'id': '2',
      'title': '부산 여행',
      'startDate': '2024-03-10',
      'endDate': '2024-03-12',
      'location': '부산광역시',
      'image': 'https://images.unsplash.com/photo-1542051841857-5f90071e7989',
    },
    {
      'id': '3',
      'title': '서울 당일치기',
      'startDate': '2024-02-15',
      'endDate': '2024-02-15',
      'location': '서울특별시',
      'image': 'https://images.unsplash.com/photo-1538485399081-7191377e8241',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                  '내 여행',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // 여행 검색
                  },
                ),
              ],
            ),
          ),

          // 탭 바
          TabBar(
            controller: _tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            tabs: const [
              Tab(text: '예정된 여행'),
              Tab(text: '지난 여행'),
            ],
          ),

          // 탭 내용
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // 예정된 여행 탭
                _isLoading
                    ? const LoadingIndicator()
                    : _upcomingTrips.isEmpty
                        ? EmptyView(
                            title: '예정된 여행이 없습니다',
                            message: '새로운 여행을 계획해보세요!',
                            icon: Icons.flight_takeoff,
                            action: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/create-trip');
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('여행 계획하기'),
                            ),
                          )
                        : _buildTripList(_upcomingTrips),

                // 지난 여행 탭
                _isLoading
                    ? const LoadingIndicator()
                    : _pastTrips.isEmpty
                        ? const EmptyView(
                            title: '지난 여행이 없습니다',
                            message: '여행 기록이 여기에 표시됩니다',
                            icon: Icons.history,
                          )
                        : _buildTripList(_pastTrips),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripList(List<Map<String, dynamic>> trips) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final trip = trips[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: InkWell(
            onTap: () {
              // 여행 상세 페이지로 이동
              Navigator.of(context)
                  .pushNamed('/trip-details', arguments: trip['id']);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 이미지
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    trip['image'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: LoadingIndicator(size: 30),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      );
                    },
                  ),
                ),

                // 정보
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip['title'],
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: AppColors.secondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            trip['location'],
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: AppColors.secondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatDateRange(
                                trip['startDate'], trip['endDate']),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDateRange(String startDate, String endDate) {
    final start = DateTime.parse(startDate);
    final end = DateTime.parse(endDate);

    final startMonth = _getMonthName(start.month);
    final endMonth = _getMonthName(end.month);

    if (start.year == end.year) {
      if (start.month == end.month) {
        if (start.day == end.day) {
          // 당일 여행
          return '$startMonth ${start.day}일, ${start.year}년';
        } else {
          // 같은 달 내 여행
          return '$startMonth ${start.day}일 - ${end.day}일, ${start.year}년';
        }
      } else {
        // 다른 달 여행, 같은 해
        return '$startMonth ${start.day}일 - $endMonth ${end.day}일, ${start.year}년';
      }
    } else {
      // 다른 해 여행 (연도 걸침)
      return '$startMonth ${start.day}일, ${start.year}년 - $endMonth ${end.day}일, ${end.year}년';
    }
  }

  String _getMonthName(int month) {
    const months = [
      '1월',
      '2월',
      '3월',
      '4월',
      '5월',
      '6월',
      '7월',
      '8월',
      '9월',
      '10월',
      '11월',
      '12월'
    ];
    return months[month - 1];
  }
}
