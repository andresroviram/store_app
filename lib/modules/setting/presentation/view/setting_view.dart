import 'package:flutter/material.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  static const String path = '/setting';
  static const String name = 'setting';

  static Widget create() => const SettingView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: const Center(
        child: Text('Setting View'),
      ),
    );
  }
}
