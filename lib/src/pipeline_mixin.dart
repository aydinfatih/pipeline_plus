import 'package:pipeline_plus/pipeline_plus.dart';

mixin PipelineMixin {
  Pipeline pipeThrough({
    required List pipes,
  }) {
    return Pipeline()
      ..send(data: this)
      ..through(pipes: pipes);
  }
}
