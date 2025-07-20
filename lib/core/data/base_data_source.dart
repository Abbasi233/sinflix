import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../error/failures.dart';

abstract class BaseDataSource {
  Future<T> handleResponse<T>(Future<HttpResponse<T>> Function() apiCall) async {
    try {
      final response = await apiCall();

      if (response.response.statusCode == 200 || response.response.statusCode == 201) {
        if (response.data != null) {
          return response.data!;
        } else {
          throw Exception('Response data is null');
        }
      } else {
        throw ServerFailure('HTTP ${response.response.statusCode}: ${response.response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final message = e.response!.statusMessage ?? 'Request failed';

        switch (statusCode) {
          case 400:
            throw BadRequestFailure(message);
          case 401:
            throw UnauthorizedFailure(message);
          case 403:
            throw ForbiddenFailure(message);
          case 404:
            throw NotFoundFailure(message);
          case 500:
            throw ServerFailure(message);
          default:
            throw ServerFailure('HTTP $statusCode: $message');
        }
      } else {
        throw NetworkFailure(e.message ?? 'Network error');
      }
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw ServerFailure(e.toString());
    }
  }
}
