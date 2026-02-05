import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _apiKey = 'nyt_api_key';
  static const String _newsCache = 'nyt_news_cache';

  // API Key Kaydet/Oku
  static Future<void> saveApiKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_apiKey, key);
  }

  static Future<String?> getApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_apiKey);
  }

  // Haber Cache Kaydet/Oku
  static Future<void> saveNewsCache(String jsonString) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_newsCache, jsonString);
  }

  static Future<String?> getNewsCache() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_newsCache);
  }
}
