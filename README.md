# pipeline_plus

[![platform](https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter)](https://flutter.dev)
[![platform](https://img.shields.io/badge/Platform-Dart-02569B?logo=dart)](https://dart.dev)
[![pub package](https://img.shields.io/pub/v/pipeline_plus.svg?label=pipeline_plus&color=02569B)](https://pub.dev/packages/pipeline_plus)
[![license](https://img.shields.io/github/license/aydinfatih/pipeline_plus?color=02569B)](https://opensource.org/licenses/BSD-3-Clause)

A Pipeline allows you to pass data through a series of pipes to perform a
sequence of operations with the data. Each pipe is a callable piece of code: A
class method, a function. Since each pipe operates on the data in isolation (the
pipes don't know or care about each other), then that means you can easily
compose complex workflows out of reusable actions that are also very easy to
test because they aren't interdependent.

## Usage

A simple usage example:

```dart
import 'package:pipeline_plus/pipeline_plus.dart';

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
```

## PipelineMixin
By implementing PipelineMixin on a class, you can use the pipeThrough method for the class.

```dart
class User with PipelineMixin {}
```

```dart
import 'package:pipeline_plus/pipeline_plus.dart';

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

```

### Sample pipe
```dart
class SendWelcomeEmailService implements Pipe<User> {
  @override
  Future<User> handle(User user) async {
    print('The welcome email is being sent.');
    user.welcomeEmailIsSent = true;

    return user;
  }
}
```
## Methods
## send
Set the data being sent through the pipeline.
```dart
..send(data: User())
```
## through
Set the list of pipes.
```dart
..through(
   pipes: [
    RegisterUserService(),
    AddMemberToTeamService(),
    (User user) {
      user.teamId = 1000;
      return user;
    },
    SendWelcomeEmailService(),
  ],
)
```
## pipe
Push additional pipes onto the pipeline.
```dart
..pipe(
    pipes: [
        AdditionalService(),
    ],
)
```
## onFailure
Set callback to be executed on failure pipeline.
```dart
..onFailure(callback: (passable, exception) {
    // do something
})
```
## then
Run the pipeline with a final destination callback.
```dart
pipeline.then(callback: (data){
// do something
});
```
## thenReturn
Run the pipeline and return the result.
```dart
var data = await pipeline.thenReturn();
```
