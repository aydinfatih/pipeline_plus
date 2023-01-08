import 'package:pipeline_plus/pipeline_plus.dart';

mixin PipelineMixin {
  Pipeline pipeThrough({
    required List pipes,
    String method = 'handle',
    List<dynamic> positionalArguments = const [],
    Map<Symbol, dynamic> namedArguments = const <Symbol, dynamic>{},
  }) {
    return Pipeline()
      ..send(data: this)
      ..through(pipes: pipes);
  }
}
