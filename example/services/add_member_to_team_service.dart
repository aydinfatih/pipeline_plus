import 'package:pipeline_plus/src/pipe.dart';

import '../model/user.dart';

class AddMemberToTeamService implements Pipe<User> {
  @override
  Future<User> handle(User user) async {
    await Future.delayed(Duration(seconds: 2));
    print('The user is being registered to team.');
    user.teamId = 1;

    return user;
  }
}
