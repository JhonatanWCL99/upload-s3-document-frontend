import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class ConfigService {
  static Map<String, dynamic>? _config;

  static Future<void> loadConfig() async {
    final configString = await rootBundle.loadString('assets/config.json');
    _config = jsonDecode(configString);
  }

  static String get apiUrl {
    if (_config == null) {
      throw Exception('Config not loaded');
    }
    return _config!['API_BASE_URL'];
  }
}
