class GetVideoRequest {
  final String title;
  final String? description;

  GetVideoRequest({
    required this.title,
    this.description,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
      };
}
