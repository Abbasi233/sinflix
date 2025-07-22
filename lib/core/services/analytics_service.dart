import 'package:firebase_analytics/firebase_analytics.dart';

abstract class AnalyticsService {
  Future<void> logEvent(String name, {Map<String, Object>? parameters});
  Future<void> setUserId(String userId);
  Future<void> setUserProperty({required String name, required String value});
}

class AnalyticsServiceImpl implements AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  Future<void> logEvent(String name, {Map<String, Object>? parameters}) {
    return _analytics.logEvent(name: name, parameters: parameters);
  }

  @override
  Future<void> setUserId(String userId) {
    return _analytics.setUserId(id: userId);
  }

  @override
  Future<void> setUserProperty({required String name, required String value}) {
    return _analytics.setUserProperty(name: name, value: value);
  }
}
