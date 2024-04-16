import 'package:flutter/material.dart';
import 'package:mba_flutter_app/form/shopping_form_screen.dart';
import 'package:mba_flutter_app/list/shopping_list_screen.dart';
import 'package:mba_flutter_app/setting/settings_screen.dart';
import 'package:mba_flutter_app/total_purchase/sub_total_screen.dart';

import '../service/sqlite_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {

  int currentScreenIndex = 0;

  final List<String> _screenTitles = [
    "Lista de Compras",
    "Ajustes",
    "Resumo da Compra"
  ];

  final List<Widget> _screens = [
    const ShoppingListScreen(),
    SettingScreen(),
    SubTotalScreen()
  ];

  //Inicializa o banco de dados ao iniciar o state
  late SqliteService _sqliteService;

  @override
  void initState(){
    super.initState();
    this._sqliteService = SqliteService();
    this._sqliteService.initializeDB().whenComplete(() async {
      //TODO Chamar método para carregar dados da tabela Products
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShoppingFormScreen(onProductAdded: () {  },))
                );
              },
              icon: const Icon(Icons.add_circle_outline_outlined)
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_screenTitles[currentScreenIndex]),
      ),
      //body: _screens[currentScreenIndex],
      body: IndexedStack(
        index: currentScreenIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreenIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentScreenIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Compras',
          ),
          NavigationDestination(
            icon: Icon(Icons.construction_outlined),
            label: 'Ajustes',
          ),
          NavigationDestination(
            icon: Icon(Icons.monetization_on_outlined),
            label: 'Total de compras',
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
