class Video {
  final String id;
  final String title;
  final String? description;
  final String thumbnailUrl;
  final String videoUrl;

  Video({
    required this.id,
    required this.title,
    this.description,
    required this.thumbnailUrl,
    required this.videoUrl,
  });

  Video.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        thumbnailUrl = json['thumbnail_url'],
        videoUrl = json['video_url'];

  // factory Video.fromJson(Map<String, dynamic> json) {
  //   return Video(
  //     id: json['id'],
  //     title: json['title'],
  //     thumbnailUrl: json['thumbnailUrl'],
  //     videoUrl: json['videoUrl'],
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'title': title,
  //     'thumbnailUrl': thumbnailUrl,
  //     'videoUrl': videoUrl,
  //   };
  // }
}
