import 'dart:convert';
import '../models/news_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class NewsRepository {
  final ApiService _apiService = ApiService();

  Future<List<NewsModel>> getNews({
    required String category,
    required String apiKey,
  }) async {
    try {
      // 1. Önce internetten taze veriyi çekmeyi dene
      final List<NewsModel> remoteNews = await _apiService.fetchNews(
        category: category,
        apiKey: apiKey,
      );

      // 2. Başarılıysa veriyi hemen cache'e (hafızaya) kaydet
      final String jsonString = jsonEncode(
        remoteNews.map((e) => e.toJson()).toList(),
      );
      await StorageService.saveNewsCache(jsonString);

      return remoteNews;
    } catch (e) {
      // 3. İnternet yoksa veya hata oluştuysa cache'e bak
      final String? cachedData = await StorageService.getNewsCache();

      if (cachedData != null) {
        final List decodedData = jsonDecode(cachedData);
        return decodedData.map((json) => NewsModel.fromJson(json)).toList();
      }

      // 4. Cache de yoksa hatayı fırlat
      rethrow;
    }
  }
}
