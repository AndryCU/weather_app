import 'package:http/http.dart' as http;
import 'package:weather_app/core/exeptions.dart';

import '../const/end_points.dart';

class ApiHandler {
  ApiHandler();
  
  Future<http.Response> get(
      {required String path,
      required Map<String, String> queryParameters}) async {
    final uri = Uri(
        host: baseUrl,
        scheme: 'https',
        path: path,
        queryParameters: queryParameters);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw ApiError(response.statusCode);
    }
  }
}
