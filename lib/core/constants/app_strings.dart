class AppStrings {
  AppStrings._(); // Nesne üretilmesini engeller

  // Uygulama Genel
  static const String appName = 'NYT News App';
  static const String homeTitle = 'NYT Top Stories';
  static const String settingsTitle = 'API Ayarları';

  // Ayarlar Ekranı
  static const String apiKeyLabel = 'New York Times API Key';
  static const String apiKeyHelper =
      'Key expired olursa buradan güncelleyebilirsiniz.';
  static const String saveButton = 'KAYDET';
  static const String keyUpdatedMsg = 'API Key başarıyla güncellendi!';

  // Ana Ekran
  static const String activeKeyLabel = 'Aktif API Key:';
  static const String loadingNews =
      'Haberler bir sonraki adımda buraya gelecek! 🚀';

  // Hatalar
  static const String errorApiKey = 'Geçersiz veya süresi dolmuş API Key!';

  // Varsayılan Key (Burada tutmak yönetimi kolaylaştırır)
  static const String defaultApiKey =
      'P6YdY7MsVfGk0HmOJqkjA9S1ZKGOylyxptGEI0J2ghjEEGuA';

  static const String baseUrl = 'https://api.nytimes.com/svc/topstories/v2/';
  static const String jsonExtension = '.json';
  static const String apiKeyQueryParam = 'api-key';

  // Timeout ve Sayısal Sabitler
  static const int connectTimeoutSeconds = 10;
  static const int receiveTimeoutSeconds = 10;

  // Hata Mesajları
  static const String errorGeneric = 'Bir ağ hatası oluştu!';
  static const String errorTimeout =
      'Bağlantı zaman aşımına uğradı, lütfen internetinizi kontrol edin.';
  static const String errorUnauthorized =
      'API Key geçersiz veya süresi dolmuş!';
  static const String errorNotFound =
      'Haberler yüklenemedi, lütfen daha sonra tekrar deneyin.';
}
