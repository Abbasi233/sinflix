import 'package:logger/logger.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

abstract class LoggerService {
  void d(dynamic message, {dynamic error, StackTrace? stackTrace});
  void i(dynamic message, {dynamic error, StackTrace? stackTrace});
  void w(dynamic message, {dynamic error, StackTrace? stackTrace});
  void e(dynamic message, {dynamic error, StackTrace? stackTrace});
  void wtf(dynamic message, {dynamic error, StackTrace? stackTrace});
}

class LoggerServiceImpl implements LoggerService {
  final Logger _logger = Logger();

  @override
  void d(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  @override
  void i(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  @override
  void w(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.w(message, error: error, stackTrace: stackTrace);
    FirebaseCrashlytics.instance.log(message.toString());
  }

  @override
  void e(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
    FirebaseCrashlytics.instance.log(message.toString());
  }

  @override
  void wtf(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.f(message, error: error, stackTrace: stackTrace);
    FirebaseCrashlytics.instance.log(message.toString());
  }
}
