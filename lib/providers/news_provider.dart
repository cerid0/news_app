import 'package:flutter/material.dart';
import 'package:news_app/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import '../data/models/news_model.dart';
import '../data/repositories/news_repository.dart';

// Ekranda hangi durumda olduğumuzu anlamak için bir enum
enum NewsState { initial, loading, loaded, error }

class NewsProvider with ChangeNotifier {
  final NewsRepository _repository = NewsRepository();

  List<NewsModel> _articles = [];
  NewsState _state = NewsState.initial;
  String _errorMessage = '';

  // Getter'lar
  List<NewsModel> get articles => _articles;
  NewsState get state => _state;
  String get errorMessage => _errorMessage;

  Future<void> loadNews({
    required String category,
    required String apiKey,
  }) async {
    _state = NewsState.loading;
    _errorMessage = '';
    notifyListeners(); // UI'a "yükleniyor" de

    try {
      _articles = await _repository.getNews(category: category, apiKey: apiKey);
      _state = NewsState.loaded;
    } catch (e) {
      _state = NewsState.error;
      _errorMessage = e.toString();
    } finally {
      notifyListeners(); // UI'ı her durumda güncelle
    }
  }

  Future<void> loadCurrentNews(BuildContext context, String category) {
    final apiKey = context.read<SettingsProvider>().apiKey;
    return loadNews(category: category, apiKey: apiKey ?? '');
  }
}
