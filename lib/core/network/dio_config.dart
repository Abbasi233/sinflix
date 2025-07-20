import 'package:dio/dio.dart';

class DioConfig {
  static Dio instance = Dio(
    BaseOptions(
      validateStatus: (_) => true,
    ),
  );
}
