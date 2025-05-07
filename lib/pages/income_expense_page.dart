import 'package:flutter/material.dart';
import 'package:flutter_practice/services/theme_service.dart';

import 'package:provider/provider.dart';

class IncomeExpensePage extends StatefulWidget {
  const IncomeExpensePage({super.key}); // Title is now handled by ScaffoldWithNavBar

  // final String title; // Title is now handled by ScaffoldWithNavBar

  @override
  State<IncomeExpensePage> createState() => _IncomeExpensePageState();
}

class _IncomeExpensePageState extends State<IncomeExpensePage> {
  double _balance = 0.0;
  final List<Map<String, dynamic>> _expenses = [];

  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _expenseAmountController =
      TextEditingController();
  final TextEditingController _expenseDescController = TextEditingController();

  void _addIncome() {
    final amount = double.tryParse(_incomeController.text);
    if (amount != null && amount > 0) {
      setState(() {
        _balance += amount;
      });
      _incomeController.clear();
    }
  }

  void _addExpense() {
    final amount = double.tryParse(_expenseAmountController.text);
    final desc = _expenseDescController.text;

    if (amount != null && amount > 0 && desc.isNotEmpty) {
      setState(() {
        _balance -= amount;
        _expenses.add({'amount': amount, 'description': desc});
      });
      _expenseAmountController.clear();
      _expenseDescController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid amount or description'),
          showCloseIcon: true,
          shape: RoundedRectangleBorder(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _incomeController.dispose();
    _expenseAmountController.dispose();
    _expenseDescController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context, listen: false);

    // Scaffold, AppBar, Drawer are now handled by ScaffoldWithNavBar
    return LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;
          double contentWidth = maxWidth > 800 ? 600 : double.infinity;

          return Center(
            child: Container(
              width: contentWidth,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Current Balance: \$${_balance.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _incomeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Add Income',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: _addIncome,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  TextField(
                    controller: _expenseAmountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Expense Amount'),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _expenseDescController,
                    decoration: InputDecoration(
                      labelText: 'Expense Description',
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple, // background color
                      foregroundColor: Colors.white, // text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: _addExpense,
                    child: const Text('Add Expense'),
                  ),
                  SizedBox(height: 20),
                  Text('Expenses:', style: TextStyle(fontSize: 18)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _expenses.length,
                      itemBuilder: (context, index) {
                        final expense = _expenses[index];
                        return ListTile(
                          leading: const Icon(Icons.money_off),
                          title: Text('\$${expense['amount']}'),
                          subtitle: Text(expense['description']),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
  }
}
