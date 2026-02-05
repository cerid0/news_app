import 'package:dio/dio.dart';
import '../models/news_model.dart';
import '../../core/constants/app_strings.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppStrings.baseUrl,
      connectTimeout: const Duration(seconds: AppStrings.connectTimeoutSeconds),
      receiveTimeout: const Duration(seconds: AppStrings.receiveTimeoutSeconds),
    ),
  );

  Future<List<NewsModel>> fetchNews({
    required String category,
    required String apiKey,
  }) async {
    try {
      final String endpoint = '$category${AppStrings.jsonExtension}';

      final response = await _dio.get(
        endpoint,
        queryParameters: {AppStrings.apiKeyQueryParam: apiKey},
      );

      if (response.statusCode == 200) {
        final List results = response.data['results'];
        return results.map((json) => NewsModel.fromJson(json)).toList();
      } else {
        throw Exception(AppStrings.errorNotFound);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception(AppStrings.errorUnauthorized);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception(AppStrings.errorTimeout);
      }
      throw Exception(AppStrings.errorGeneric);
    }
  }
}
