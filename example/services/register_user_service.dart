import 'package:pipeline_plus/src/pipe.dart';

import '../model/user.dart';

class RegisterUserService implements Pipe<User> {
  @override
  Future<User> handle(User user) async {
    print('The user is being registered.');
    user.isRegistered = true;

    return user;
  }
}
