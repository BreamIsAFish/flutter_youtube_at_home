import 'package:flutter_youtube_at_home/feature/user/domain/post_login_request.dart';

abstract class UserProvider {
  Future<void> postLogin(PostLoginRequest requestData);
}

class UserRepository {
  final UserProvider userProvider;

  UserRepository({required this.userProvider});

  Future<void> postLogin(PostLoginRequest requestData) async {
    return userProvider.postLogin(requestData);
  }
}
