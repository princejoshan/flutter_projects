import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  // Private constructor
  AnalyticsService._internal();

  // Singleton instance
  static final AnalyticsService _instance = AnalyticsService._internal();

  // Factory constructor to return the singleton instance
  factory AnalyticsService() => _instance;

  // Firebase Analytics instance
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // Logging a custom event
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters}) async {
    await _analytics.logEvent(
      name: name,
      parameters: parameters?.map((key, value) => MapEntry(key, value as Object)),
    );
  }

  // Setting user properties
  Future<void> setUserProperty(String name, String value) async {
    await _analytics.setUserProperty(name: name, value: value);
  }

// Add other analytics methods as needed
}