import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_strings.dart';
import 'package:provider/provider.dart';
import '../../providers/settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Mevcut key'i controller'a aktarıyoruz
    final currentKey = context.read<SettingsProvider>().apiKey;
    _controller = TextEditingController(text: currentKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.settingsTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: AppStrings.apiKeyLabel,
                border: OutlineInputBorder(),
                helperText: AppStrings.apiKeyHelper,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<SettingsProvider>().setApiKey(_controller.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(AppStrings.keyUpdatedMsg)),
                );
              },
              child: const Text(AppStrings.saveButton),
            ),
          ],
        ),
      ),
    );
  }
}
