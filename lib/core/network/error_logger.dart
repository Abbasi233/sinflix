import 'dart:developer';
import 'package:dio/dio.dart' show RequestOptions;
import 'package:retrofit/error_logger.dart' show ParseErrorLogger;

class ErrorLogger extends ParseErrorLogger {
  @override
  void logError(Object error, StackTrace stackTrace, RequestOptions options) {
    log(error.toString(), stackTrace: stackTrace, name: 'ErrorLogger');
  }
}
