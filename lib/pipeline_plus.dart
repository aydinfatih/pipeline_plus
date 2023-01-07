/// A Pipeline allows you to pass data through a series of pipes to perform a
/// sequence of operations with the data. Each pipe is a callable piece of code:
/// A class method, a function. Since each pipe operates on the data in isolation
/// (the pipes don't know or care about each other), then that means you can
/// easily compose complex workflows out of reusable actions that are also very
/// easy to test because they aren't interdependent.
library pipeline_plus;

export 'src/pipeline_base.dart';
export 'src/pipeline_mixin.dart';
