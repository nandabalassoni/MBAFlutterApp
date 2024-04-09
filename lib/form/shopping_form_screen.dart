import 'package:flutter/material.dart';

class ShoppingFormScreen extends StatelessWidget {

  const ShoppingFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de produto"),
      ),
      body: Center(child: Text('ShoppingFormView'),),
    );
  }
}