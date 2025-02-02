class Apiexception implements Exception {
  final String message;

  Apiexception(this.message);

  @override
  String toString() {
    return message;
  }
}
