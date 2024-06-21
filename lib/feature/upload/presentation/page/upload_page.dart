import 'package:flutter/material.dart';
import 'package:flutter_youtube_at_home/feature/upload/presentation/widget/upload_form.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Upload Page',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.red[900],
              ),
            ),
            const UploadForm()
          ],
        ),
      ),
    );
  }
}
