import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_practice/widgets/app_drawer.dart';
import 'package:flutter_practice/widgets/common_bottom_nav.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

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
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Counter Page'),
      ),
      drawer: AppDrawer(),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
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
              backgroundColor: Colors.deepOrangeAccent,
              child: const Icon(Icons.refresh),
            ),
          ),
          SizedBox(height: 16), // space between buttons
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
      bottomNavigationBar: CommonBottomNav(
        currentIndex: 0,
      ),
    );
  }
}
