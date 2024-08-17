import 'package:dio/dio.dart';
import 'package:msiglife_test/utils/api_constants.dart';

class DioUtils {
  const DioUtils._();

  static Future<Dio> client() async {
    final dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {'Content-Type': 'application/json'},
    ));
    return dio;
  }
}
