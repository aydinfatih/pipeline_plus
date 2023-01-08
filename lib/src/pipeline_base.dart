import 'package:pipeline_plus/src/pipe.dart';

/// Checks if you are awesome. Spoiler: you are.
class Pipeline {
  /// The method to call on each pipe.
  /// If pipe is a function, it is not called.
  String _method = 'handle';

  /// The list of positional arguments
  List<dynamic> _positionalArguments = [];

  /// The map of positional arguments
  Map<Symbol, dynamic> _namedArguments = {};

  /// The list of pipes
  List _pipes = [];

  /// The object being passed through the pipeline.
  dynamic _data;

  /// The callback to be executed on failure pipeline.
  Function(dynamic data, dynamic exception)? _onFailure;

  /// Set the data being sent through the pipeline.
  void send({required dynamic data}) {
    _data = data;
  }

  /// Set the list of pipes.
  void through({required List pipes}) {
    _pipes = pipes;
  }

  /// Push additional pipes onto the pipeline.
  void pipe({required List pipes}) {
    _pipes.addAll(pipes);
  }

  /// Set the method to call on the pipes.
  /// You can pass if the pipe accepts positional arguments other than data.
  /// You can pass if the pipe accepts named arguments other than data.
  /// Note: The data variable is passed to the pipe independently of these variables.
  void via({required String method, List<dynamic> positionalArguments = const [], Map<Symbol, dynamic> namedArguments = const <Symbol, dynamic>{}}) {
    _method = method;
    _positionalArguments = positionalArguments;
    _namedArguments = namedArguments;
  }

  /// Run the pipeline with a final destination callback.
  Future<dynamic> then({required Function(dynamic data) callback}) async {
    try {
      await Future.forEach(_pipes, (pipe) async {
        if (pipe is Function) {
          _data = await Function.apply(pipe, [_data]);
        } else if (pipe is Pipe) {
          _data = await Function.apply(pipe.handle, [_data]);
        }
      });

      return callback(_data);
    } catch (exception) {
      if (_onFailure != null) {
        return _onFailure!(_data, exception);
      }

      rethrow;
    }
  }

  /// Run the pipeline and return the result.
  dynamic thenReturn() async {
    return await then(callback: (data) => data);
  }

  /// Set callback to be executed on failure pipeline.
  void onFailure({required Function(dynamic data, dynamic exception) callback}) {
    _onFailure = callback;
  }
}
