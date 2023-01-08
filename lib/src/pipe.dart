abstract class Pipe<T> {
  Future<T> handle(T data);
}
