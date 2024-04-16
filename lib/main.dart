import 'package:flutter/material.dart';
import 'package:mba_flutter_app/home/home_screen.dart';
import 'package:mba_flutter_app/provider/settingProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingProvider(),
      child: const HomeScreen(),
    ),
  );
}