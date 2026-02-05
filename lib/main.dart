import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_strings.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/providers/settings_provider.dart';
import 'package:news_app/ui/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  // SharedPreferences için async başlatma şart
  WidgetsFlutterBinding.ensureInitialized();

  final settingsProvider = SettingsProvider();
  final newsProvider = NewsProvider();
  await settingsProvider.loadSettings(); // Önce verileri yükle

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: settingsProvider),
        ChangeNotifierProvider.value(value: newsProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      ),
      home: const HomeScreen(),
    );
  }
}
