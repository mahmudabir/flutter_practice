import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import go_router

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.black54),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Counter Page'),
            onTap: () {
              // Navigator.pop(context); // Close the drawer
              context.go('/counter'); // Navigate using go_router
            },
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Income & Expense Tracker'),
            onTap: () {
              // Navigator.pop(context); // Close the drawer
              context.go('/income-expense'); // Navigate using go_router
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Navigator.pop(context); // Close the drawer
              context.go('/settings'); // Navigate using go_router
            },
          ),
        ],
      ),
    );
  }
}
