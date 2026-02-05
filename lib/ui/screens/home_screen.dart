// lib/ui/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:news_app/ui/mixins/news_mixin.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_strings.dart';
import '../../providers/news_provider.dart';
import '../widgets/news_card.dart';
import '../widgets/news_shimmer.dart'; // Yeni eklendi
import 'news_detail_screen.dart'; // Yeni eklendi
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with NewsMixin {
  String _selectedCategory = 'arts';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchNews(context, _selectedCategory);
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = context.watch<NewsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.homeTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const SettingsScreen())),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategoryList(),
          // RefreshIndicator tüm body'yi sarmalı
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => fetchNews(context, _selectedCategory),
              child: _buildBody(newsProvider),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    final categories = [
      'arts',
      'automobiles',
      'books/review',
      'business',
      'fashion',
      'food',
      'health',
      'home',
      'insider',
      'magazine',
      'nyregion',
      'obituaries',
      'opinion',
      'politics',
      'realestate',
      'science',
      'sports',
      'sundayreview',
      'technology',
      'theater',
      't-magazine',
      'travel',
      'upshot',
      'us',
      'world',
    ];
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(cat.toUpperCase()),
              selected: _selectedCategory == cat,
              onSelected: (selected) {
                if (selected) {
                  setState(() => _selectedCategory = cat);
                  fetchNews(context, _selectedCategory);
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(NewsProvider provider) {
    switch (provider.state) {
      case NewsState.loading:
        return const NewsShimmer(); // Shimmer burada kullanıldı

      case NewsState.error:
        // RefreshIndicator'ın çalışması için ListView veya SingleChildScrollView şarttır
        return ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(provider.errorMessage),
                    ElevatedButton(
                      onPressed: () => fetchNews(context, _selectedCategory),
                      child: const Text('Tekrar Dene'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );

      case NewsState.loaded:
        if (provider.articles.isEmpty) {
          return const Center(child: Text("Haber bulunamadı."));
        }
        return ListView.builder(
          // ListView her zaman scroll edilebilir olmalı (RefreshIndicator için)
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: provider.articles.length,
          itemBuilder: (context, index) {
            final article = provider.articles[index];
            return NewsCard(
              article: article,
              onTap: () {
                // WebView sayfasına yönlendirme
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailScreen(article: article),
                  ),
                );
              },
            );
          },
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
