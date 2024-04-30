import 'package:flutter/material.dart';
import 'package:mba_flutter_app/form/shopping_form_screen.dart';
import 'package:mba_flutter_app/list/shopping_list_screen.dart';
import 'package:mba_flutter_app/repository/sqlite_repository.dart';
import 'package:mba_flutter_app/setting/settings_screen.dart';
import 'package:mba_flutter_app/total_purchase/sub_total_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
        ),
        useMaterial3: true,
      ),
      home: _MyHomeScreen(),
    );
  }
}

class _MyHomeScreen extends StatefulWidget {
  @override
  State<_MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<_MyHomeScreen> {
  int _currentScreenIndex = 0;

  final List<String> _screenTitles = [
    "Lista de Compras",
    "Ajustes",
    "Resumo da Compra"
  ];

  final List<Widget> _screens = [
    const ShoppingListScreen(),
    const SettingScreen(),
    const SubTotalScreen()
  ];

  @override
  void initState() {
    super.initState();
    SqliteRepository().initializeDB().whenComplete(() async {});
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
                MaterialPageRoute(
                  builder: (context) => ShoppingFormScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.add_circle_outline_outlined,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: Colors.blueAccent.withOpacity(0.8),
        title: Text(
          _screenTitles[_currentScreenIndex],
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: IndexedStack(
        index: _currentScreenIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentScreenIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentScreenIndex = index;
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
