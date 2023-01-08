import 'package:pipeline_plus/pipeline_plus.dart';

class User with PipelineMixin {
  bool isRegistered;
  int? teamId;
  bool welcomeEmailIsSent;

  User(
      {this.isRegistered = false,
      this.teamId,
      this.welcomeEmailIsSent = false});

  @override
  String toString() {
    return 'User{isRegistered: $isRegistered, teamId: $teamId, welcomeEmailIsSent: $welcomeEmailIsSent}';
  }
}
