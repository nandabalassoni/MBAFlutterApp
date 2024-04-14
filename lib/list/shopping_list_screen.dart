import 'package:flutter/material.dart';
import 'package:mba_flutter_app/form/shopping_form_screen.dart';

class ShoppingListScreen extends StatelessWidget {

  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.amberAccent.withAlpha(30),
              onTap: () {
                print("Card tapped");
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShoppingFormScreen())
                );
              },
              child: ListTile(
                leading: FlutterLogo(),
                title: Text('One-line'),
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.amberAccent.withAlpha(30),
              onTap: () {
                print("Card tapped");
              },
              child: ListTile(
                leading: FlutterLogo(),
                title: Text('One-line'),
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.amberAccent.withAlpha(30),
              onTap: () {
                print("Card tapped");
              },
              child: ListTile(
                leading: FlutterLogo(),
                title: Text('One-line'),
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.amberAccent.withAlpha(30),
              onTap: () {
                print("Card tapped");
              },
              child: ListTile(
                leading: FlutterLogo(),
                title: Text('One-line'),
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.amberAccent.withAlpha(30),
              onTap: () {
                print("Card tapped");
              },
              child: ListTile(
                leading: FlutterLogo(),
                title: Text('One-line'),
              ),
            ),
          ),
        ],
    );
  }
}