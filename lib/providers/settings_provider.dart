import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_strings.dart';
import '../data/services/storage_service.dart';

class SettingsProvider with ChangeNotifier {
  String? _apiKey;

  String? get apiKey => _apiKey ?? AppStrings.defaultApiKey;

  // Uygulama açıldığında kayıtlı key'i yükler
  Future<void> loadSettings() async {
    _apiKey = await StorageService.getApiKey();
    notifyListeners();
  }

  // Yeni API Key set eder ve kaydeder
  Future<void> setApiKey(String key) async {
    _apiKey = key;
    await StorageService.saveApiKey(key);
    notifyListeners();
  }

  // Key'in olup olmadığını kontrol eder
  bool get hasValidKey => _apiKey != null && _apiKey!.length > 10;
}
