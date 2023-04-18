class RetreivalFailedException implements Exception {
  final String message;
  final int? statusCode;

  RetreivalFailedException(this.message, [this.statusCode]);

  @override
  String toString() {
    if (statusCode != null) {
      return 'RetreivalFailedException: $message (status code $statusCode)';
    } else {
      return 'RetreivalFailedException: $message';
    }
  }
}
