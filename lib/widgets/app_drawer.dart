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
            decoration: BoxDecoration(color: Colors.blueGrey),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Counter Page'),
            onTap: () {
              context.go('/counter'); // Navigate using go_router
            },
          ),
          ExpansionTile(
            leading: Icon(Icons.attach_money),
            title: Text('Income/Expense'),
            children: [
              ListTile(
                leading: Icon(Icons.list),
                title: Text('Overview'),
                onTap: () {
                  context.go('/income-expense');
                },
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Add Income'),
                onTap: () {
                  context.go('/income-expense/add-income');
                },
              ),
              ListTile(
                leading: Icon(Icons.remove),
                title: Text('Add Expense'),
                onTap: () {
                  context.go('/income-expense/add-expense');
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              context.go('/settings'); // Navigate using go_router
            },
          ),
        ],
      ),
    );
  }
}
