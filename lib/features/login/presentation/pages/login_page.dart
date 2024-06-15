import 'package:flutter/material.dart';
import 'package:flutter_youtube_at_home/features/login/presentation/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
            'Welcome to \nYoutube @Home!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.red[900],
            ),
          ),
          SizedBox(height: 20),
          LoginForm(),
        ],
      )),
    );
  }
}
