import 'package:flutter/material.dart';
import 'package:flutter_youtube_at_home/features/video/data/network/video_api_data_provider.dart';
import 'package:flutter_youtube_at_home/features/video/data/repository/video_repository.dart';
import 'package:flutter_youtube_at_home/features/video/domain/video.dart';
import 'package:flutter_youtube_at_home/features/video/presentation/pages/video_page.dart';

class HomeVideoList extends StatefulWidget {
  final _videoRepository =
      VideoRepository(videoProvider: VideoAPIDataProvider());

  HomeVideoList({super.key});

  @override
  State<HomeVideoList> createState() => _HomeVideoListState();
}

class _HomeVideoListState extends State<HomeVideoList> {
  Future<List<Video>>? _videoList;

  _handleClickVideo(Video video) {
    Navigator.pushNamed(context, '/video',
        arguments: VideoPageArguments(video));
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => VideoPage(),
    //   ),
    // );
  }

  @override
  void initState() {
    super.initState();
    _videoList = widget._videoRepository.getVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder<List<Video>>(
      future: _videoList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final video = snapshot.data![index];
              return ListTile(
                onTap: () => _handleClickVideo(video),
                title: Text(video.title),
                subtitle: Text(video.description ?? ''),
                leading: Image.network(video.thumbnailUrl),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Failed to load videos'),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}
