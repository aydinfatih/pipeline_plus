# Pipeline
A Pipeline allows you to pass data through a series of pipes to perform a sequence of operations with the data. Each pipe is a callable piece of code: A class method, a function. Since each pipe operates on the data in isolation (the pipes don't know or care about each other), then that means you can easily compose complex workflows out of reusable actions that are also very easy to test because they aren't interdependent.

>Each pipe in the process must retrieve and return the same type of data.

## Usage

A simple usage example:

```dart
import 'package:pipeline/pipeline.dart';

var pipeline = Pipeline()
..send(data: User())
..via(method: 'handle')
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
import 'package:pipeline/pipeline.dart';

var userPipeline = User().pipeThrough(
  method: 'handle',
  pipes: [
    RegisterUserService(),
    AddMemberToTeamService(),
    (User user) {
      // do something
      return user;
    },
    SendWelcomeEmailService(),
  ],
  positionalArguments: [],
  namedArguments: {},
);

```

### Sample pipe
```dart
class SendWelcomeEmailService {
  Future<dynamic> handle(User user) async {
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
## via
Set the method to call on the pipes.
You can pass if the pipe accepts positional arguments other than data.
You can pass if the pipe accepts named arguments other than data.
>Note: The data variable is passed to the pipe independently of these variables.
```dart
..via(method: 'handle', positionalArguments: [], namedArguments: {})
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
