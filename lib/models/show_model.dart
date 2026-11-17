class ShowModel {
  const ShowModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    this.genre = '',
    this.platform = '',
    this.releaseDate = '',
    this.summary = '',
    this.description = '',
    this.screenshots = const [],
  });

  final int id;
  final String title;
  final String thumbnail;
  final String genre;
  final String platform;
  final String releaseDate;
  final String summary;
  final String description;
  final List<String> screenshots;
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': title,
      'image': thumbnail,
      'genre': genre,
      'platform': platform,
    };
  }

  factory ShowModel.fromMap(Map<String, dynamic> map) {
    return ShowModel(
      id: (map['id'] as num?)?.toInt() ?? 0,
      title: map['name'] as String? ?? 'Untitled game',
      thumbnail: map['image'] as String? ?? '',
      genre: map['genre'] as String? ?? '',
      platform: map['platform'] as String? ?? '',
      summary: map['summary'] as String? ?? '',
      description: map['description'] as String? ?? '',
      screenshots:
          (map['screenshots'] as List<dynamic>?)
              ?.whereType<String>()
              .toList() ??
          const [],
    );
  }
}
