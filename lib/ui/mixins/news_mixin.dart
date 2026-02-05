import 'package:flutter/material.dart';
import 'package:news_app/providers/news_provider.dart';

import 'package:provider/provider.dart';

mixin NewsMixin {
  // Bu mixin, sadece State sınıflarında kullanılabilecek şekilde kısıtlanabilir

  Future<void> fetchNews(BuildContext context, String category) {
    // Provider'a eklediğin o "tek satırlık" fonksiyonu burada çağırıyoruz
    return context.read<NewsProvider>().loadCurrentNews(context, category);
  }
}
