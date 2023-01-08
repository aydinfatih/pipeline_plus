import 'package:pipeline_plus/src/pipe.dart';

import '../model/user.dart';

class SendWelcomeEmailService implements Pipe<User> {
  @override
  Future<User> handle(User user) async {
    print('The welcome email is being sent.');
    user.welcomeEmailIsSent = true;

    return user;
  }
}
