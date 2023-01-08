import 'package:pipeline_plus/pipeline_plus.dart';

import 'model/user.dart';
import 'services/add_member_to_team_service.dart';
import 'services/register_user_service.dart';
import 'services/send_welcome_email_service.dart';

void main() async {
  var pipeline = Pipeline()
    ..send(data: User())
    ..onFailure(callback: (passable, exception) {
      // do something
    })
    ..through(
      pipes: [
        RegisterUserService(),
        AddMemberToTeamService(),
        (User user) {
          // do something
          return user;
        },
        SendWelcomeEmailService(),
      ],
    );

  print('pipeline: ${await pipeline.thenReturn()}');

  var userPipeline = User().pipeThrough(
    pipes: [
      RegisterUserService(),
      AddMemberToTeamService(),
      (User user) {
        // do something
        return user;
      },
      SendWelcomeEmailService(),
    ],
  );

  print('userPipeline: ${await userPipeline.thenReturn()}');
}
