import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {

  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Counter Page'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/counter');
            },
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Income & Expense Tracker'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/income-expense');
            },
          ),
        ],
      ),
    );
  }
}
