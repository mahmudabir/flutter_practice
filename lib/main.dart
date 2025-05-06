import 'package:flutter/material.dart';
import 'package:flutter_practice/pages/counter_page.dart';
import 'package:flutter_practice/pages/income_expense_page.dart';
import 'package:flutter_practice/services/theme_service.dart'; 
import 'package:flutter_practice/themes/app_themes.dart'; 
import 'package:provider/provider.dart'; 

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Watch for theme changes
    final themeService = Provider.of<ThemeService>(context);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppThemes.lightTheme, 
      darkTheme: AppThemes.darkTheme, 
      themeMode: themeService.themeMode, 
      // Removed duplicated theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      // ),
      initialRoute: '/counter',
      routes: {
        '/counter': (context) => const CounterPage(),
        '/income-expense': (context) => const IncomeExpensePage(),
      },
    );
  }
}
