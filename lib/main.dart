import 'package:flutter/material.dart';
import 'package:mba_flutter_app/home/home_screen.dart';
import 'package:mba_flutter_app/provider/shoppingProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ShoppingProvider(),
      child: const HomeScreen(),
    ),
  );
}