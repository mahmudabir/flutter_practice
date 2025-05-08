import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import go_router

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
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
                Navigator.pop(context);
                context.go('/counter'); // Navigate using go_router
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Income/Expense'),
              onTap: () {
                Navigator.pop(context);
                context.push('/income-expense'); // Navigate using go_router
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Income'),
              onTap: () {
                Navigator.pop(context);
                context.push('/add-income');
              },
            ),
            ListTile(
              leading: Icon(Icons.remove),
              title: Text('Add Expense'),
              onTap: () {
                Navigator.pop(context);
                context.push('/add-expense');
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
                    Navigator.pop(context);
                    context.push('/income-expense');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text('Add Income'),
                  onTap: () {
                    context.push('/income-expense/add-income');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.remove),
                  title: Text('Add Expense'),
                  onTap: () {
                    context.push('/income-expense/add-expense');
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                context.push('/settings'); // Navigate using go_router
              },
            ),
          ],
        ),
      ),
    );
  }
}
