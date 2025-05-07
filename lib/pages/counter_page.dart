import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_practice/services/theme_service.dart';

import 'package:provider/provider.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({
    super.key,
    // this.title = 'Counter Page', // Title is now handled by ScaffoldWithNavBar
  });

  // final String? title; // Title is now handled by ScaffoldWithNavBar

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  Timer? _timer;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _startIncreasing(LongPressStartDetails lpsd) {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      _incrementCounter();
    });
  }

  void _stopIncreasing(LongPressEndDetails lped) {
    _timer?.cancel();
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text('$_counter', style: Theme.of(context).textTheme.displayLarge),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Tooltip(
            message: 'Reset Counter',
            preferBelow: false, // set to true or false
            child: FloatingActionButton(
              heroTag: 'reset',
              onPressed: _resetCounter,
              // backgroundColor: Colors.deepOrangeAccent, // Removed to use AppTheme
              child: const Icon(Icons.refresh),
            ),
          ),
          const SizedBox(height: 16), // space between buttons
          GestureDetector(
            onLongPressStart: _startIncreasing,
            onLongPressEnd: _stopIncreasing,
            child: FloatingActionButton(
              heroTag: 'increment',
              onPressed: _incrementCounter,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
