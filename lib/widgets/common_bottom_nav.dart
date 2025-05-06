import 'package:flutter/material.dart';

class CommonBottomNav extends StatelessWidget {
  final int currentIndex;

  const CommonBottomNav({
    super.key,
    required this.currentIndex,
  });

  static final _items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.attach_money),
      label: 'Tracker',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  void _handleTap(BuildContext context, int index) {
    if (index == currentIndex) return;
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/counter');
        break;
      case 1:
        Navigator.pushNamed(context, '/tracker');
        break;
      case 2:
        try {
          Navigator.pushNamed(context, '/settings');
        } catch (e) {
          debugPrint('Error navigating to settings: $e');
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _handleTap(context, index),
      items: _items,
      selectedItemColor: Colors.grey.withValues(alpha: 0.4),
    );
  }
}