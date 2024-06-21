import 'package:flutter/material.dart';
import 'package:flutter_youtube_at_home/feature/user/domain/post_login_request.dart';
import 'package:flutter_youtube_at_home/feature/user/data/network/user_api_data_provider.dart';
import 'package:flutter_youtube_at_home/feature/user/data/repository/user_repository.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final UserRepository _userRepository = UserRepository(
    userProvider: UserAPIDataProvider(),
  );

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled = false;

  _validateForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isButtonEnabled = true;
      });
    } else {
      setState(() {
        _isButtonEnabled = false;
      });
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // final emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    // final regex = RegExp(emailPattern);
    // if (!regex.hasMatch(value)) {
    //   return 'Enter a valid email';
    // }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Perform login action
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logging in'),
          duration: Duration(seconds: 1),
        ),
      );
      try {
        print('Logging in');
        await _userRepository.postLogin(PostLoginRequest(
          username: _usernameController.text,
          password: _passwordController.text,
        ));
        print('Logged in');
        Navigator.pushNamed(context, '/home');
      } catch (err) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to login: $err')),
        );
      }
      // Future.delayed(const Duration(seconds: 2), () {
      //   Navigator.pushNamed(context, '/home');
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          // color: Colors.blueGrey[500],
          border: Border.all(
              color: Colors.red[900]!, style: BorderStyle.solid, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              onChanged: _validateForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter your username',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: _validatePassword,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isButtonEnabled ? _submitForm : null,
                    child: Text('Submit'),
                  ),
                ],
              )),
        ));
  }
}
