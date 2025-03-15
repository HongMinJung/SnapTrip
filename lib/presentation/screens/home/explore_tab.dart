import 'package:flutter/material.dart';
import 'package:snap_trip/core/theme/app_theme.dart';
import 'package:snap_trip/core/widgets/loading_indicator.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  final _searchController = TextEditingController();
  bool _isLoading = false;
  bool _showSearchBar = false; // 검색창 표시 여부를 관리할 상태 변수

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // 앱 바
          SliverAppBar(
            floating: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: const Text(
              '여행 둘러보기',
              style: TextStyle(color: AppColors.textPrimary),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: AppColors.textPrimary),
                onPressed: () {
                  // 검색 아이콘 클릭 시 상태 변경
                  setState(() {
                    _showSearchBar = !_showSearchBar;
                  });
                },
              ),
            ],
          ),

          // 검색 바 - 조건부 표시
          if (_showSearchBar)
            // 검색 바
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  autofocus: true,
                  style: const TextStyle(
                      fontSize: 16, color: AppColors.textPrimary),
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: '목적지, 테마, 키워드를 검색해보세요.',
                    hintStyle: TextStyle(color: AppColors.textSecondary),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        // // 검색사항
                        // setState(() {
                        //   _showSearchBar = false;
                        // });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ),

          // 추천 여행 섹션
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '추천 여행',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      // 추천 여행 더보기
                    },
                    child: const Text('더보기'),
                  ),
                ],
              ),
            ),
          ),

          // 추천 여행 목록
          SliverToBoxAdapter(
            child: SizedBox(
              height: 220,
              child: _isLoading
                  ? const LoadingIndicator()
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: 5, // 실제 데이터로 대체
                      itemBuilder: (context, index) {
                        return _buildRecommendedTripCard(context, index);
                      },
                    ),
            ),
          ),

          // 인기 목적지 섹션
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '인기 목적지',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      // 인기 목적지 더보기
                    },
                    child: const Text('더보기'),
                  ),
                ],
              ),
            ),
          ),

          // 인기 목적지 그리드
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.5,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildPopularDestinationCard(context, index);
                },
                childCount: 6, // 실제 데이터로 대체
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedTripCard(BuildContext context, int index) {
    // 임시 데이터
    final List<Map<String, dynamic>> dummyData = [
      {
        'title': '서울 시내 당일치기',
        'image': 'https://images.unsplash.com/photo-1538485399081-7191377e8241',
        'duration': '당일',
        'rating': 4.5,
      },
      {
        'title': '부산 해운대 여행',
        'image': 'https://images.unsplash.com/photo-1542051841857-5f90071e7989',
        'duration': '2박 3일',
        'rating': 4.8,
      },
      {
        'title': '제주도 한 바퀴',
        'image': 'https://images.unsplash.com/photo-1590553866560-9da91a414bab',
        'duration': '3박 4일',
        'rating': 4.9,
      },
      {
        'title': '강원도 양양 서핑',
        'image': 'https://images.unsplash.com/photo-1506953823976-52e1fdc0149a',
        'duration': '1박 2일',
        'rating': 4.6,
      },
      {
        'title': '전주 한옥마을',
        'image': 'https://images.unsplash.com/photo-1578167635617-62e828965bcf',
        'duration': '당일',
        'rating': 4.4,
      },
    ];

    final data = dummyData[index % dummyData.length];

    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            // 여행 상세 페이지로 이동
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 이미지
              Expanded(
                child: Image.network(
                  data['image'],
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
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['title'],
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          data['duration'],
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const Spacer(),
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          data['rating'].toString(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularDestinationCard(BuildContext context, int index) {
    // 임시 데이터
    final List<Map<String, dynamic>> dummyData = [
      {
        'name': '서울',
        'image': 'https://images.unsplash.com/photo-1538485399081-7191377e8241',
      },
      {
        'name': '부산',
        'image': 'https://images.unsplash.com/photo-1542051841857-5f90071e7989',
      },
      {
        'name': '제주',
        'image': 'https://images.unsplash.com/photo-1590553866560-9da91a414bab',
      },
      {
        'name': '경주',
        'image': 'https://images.unsplash.com/photo-1627894483216-2138af692e32',
      },
      {
        'name': '강릉',
        'image': 'https://images.unsplash.com/photo-1597218086880-1cf77200b249',
      },
      {
        'name': '여수',
        'image': 'https://images.unsplash.com/photo-1589198376984-58cda9ba42ce',
      },
    ];

    final data = dummyData[index % dummyData.length];

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // 목적지 상세 페이지로 이동
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 배경 이미지
            Image.network(
              data['image'],
              fit: BoxFit.cover,
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

            // 그라데이션 오버레이
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),

            // 텍스트
            Positioned(
              bottom: 12,
              left: 12,
              child: Text(
                data['name'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
