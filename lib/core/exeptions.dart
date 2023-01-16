class ApiError implements Exception {
  late final int code;
  ApiError(this.code);
  get message => 'Ha ocurrido un error: $code';
}

class NoInternetException implements Exception {
  String get message => "No hay conexion a internet";
}
