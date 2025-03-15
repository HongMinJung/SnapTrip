class TripModel {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isPublic;
  final String? coverImageUrl;
  final DateTime createdAt;
  final DateTime? updatedAt;

  TripModel({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.isPublic = false,
    this.coverImageUrl,
    required this.createdAt,
    this.updatedAt,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      endDate:
          json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      isPublic: json['is_public'] ?? false,
      coverImageUrl: json['cover_image_url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'is_public': isPublic,
      'cover_image_url': coverImageUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  TripModel copyWith({
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    bool? isPublic,
    String? coverImageUrl,
  }) {
    return TripModel(
      id: this.id,
      userId: this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isPublic: isPublic ?? this.isPublic,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      createdAt: this.createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
