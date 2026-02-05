class NewsModel {
  final String section;
  final String title;
  final String abstract;
  final String url;
  final String byline;
  final String publishedDate;
  final String imageUrl;

  NewsModel({
    required this.section,
    required this.title,
    required this.abstract,
    required this.url,
    required this.byline,
    required this.publishedDate,
    required this.imageUrl,
  });

  // JSON'dan modele dönüştürme (Factory Constructor)
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    String img = '';

    // Multimedia kontrolü: Liste var mı ve boş mu değil mi?
    if (json['multimedia'] != null && (json['multimedia'] as List).isNotEmpty) {
      final List multimedia = json['multimedia'];

      // Profesyonel dokunuş: 'Super Jumbo' formatını arayalım, yoksa ilkini alalım.
      final jumboImage = multimedia.firstWhere(
        (element) => element['format'] == 'Super Jumbo',
        orElse: () => multimedia[0],
      );

      img = jumboImage['url'] ?? '';
    }

    return NewsModel(
      section: json['section'] ?? '',
      title: json['title'] ?? '',
      abstract: json['abstract'] ?? '',
      url: json['url'] ?? '',
      byline: json['byline'] ?? '',
      publishedDate: json['published_date'] ?? '',
      imageUrl: img,
    );
  }

  // Caching (shared_preferences) için modelden Map'e dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'section': section,
      'title': title,
      'abstract': abstract,
      'url': url,
      'byline': byline,
      'published_date': publishedDate,
      'imageUrl': imageUrl,
    };
  }
}
