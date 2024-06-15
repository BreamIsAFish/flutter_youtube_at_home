import 'package:flutter_youtube_at_home/features/video/data/repository/video_repository.dart';
import 'package:flutter_youtube_at_home/features/video/domain/video.dart';
import 'package:http/http.dart' as http;

class VideoAPIDataProvider extends VideoProvider {
  @override
  Future<List<Video>> getVideos() async {
    final res = await http.get(Uri.parse('...'));
    // if (res.statusCode == 200) {
    //   return [];
    // } else {
    //   throw Exception('Failed to load videos');
    // }
    return [
      Video(
          id: '1',
          title: 'First Video',
          description: 'This is the first video',
          thumbnailUrl:
              'https://uploads.dailydot.com/2018/10/olli-the-polite-cat.jpg?q=65&auto=format&w=1600&ar=2:1&fit=crop',
          videoUrl:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
    ];
  }

  @override
  Future<void> uploadVideo(Video video) async {
    final res = await http.post(Uri.parse('...'));
    // if (res.statusCode != 200) {
    //   // return Video();
    //   // } else {
    //   throw Exception('Failed to upload video');
    // }
  }
}
