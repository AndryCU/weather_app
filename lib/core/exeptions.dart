class ApiError implements Exception {
  late final int code;
  ApiError(this.code);
  get message => 'An error has occurred. Error code: $code';
}

class NoInternetException implements Exception {
  String get message => "There is no Internet connection";
}
