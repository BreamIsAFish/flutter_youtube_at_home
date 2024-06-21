import 'package:flutter/material.dart';
import 'package:flutter_youtube_at_home/feature/home/presentation/widget/home_video_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'lib/assets/youtube_logo.png',
            width: 100,
            height: 100,
          ),
          Text(
            'Youtube @Home',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.red[900],
            ),
          ),
          SizedBox(height: 20),
          HomeVideoList(),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/upload');
              },
              child: Text('Upload'),
            ),
          ),
        ],
      )),
    );
  }
}
