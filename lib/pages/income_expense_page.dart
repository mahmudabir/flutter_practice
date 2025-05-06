import 'package:flutter/material.dart';
import 'package:flutter_practice/widgets/app_drawer.dart';

class IncomeExpensePage extends StatefulWidget {
  const IncomeExpensePage({super.key, required this.title});

  final String title;

  @override
  State<IncomeExpensePage> createState() => _IncomeExpensePageState();
}

class _IncomeExpensePageState extends State<IncomeExpensePage> {
  double balance = 0.0;
  List<Map<String, dynamic>> expenses = [];

  final TextEditingController incomeController = TextEditingController();
  final TextEditingController expenseAmountController = TextEditingController();
  final TextEditingController expenseDescController = TextEditingController();

  void _addIncome() {
    final amount = double.tryParse(incomeController.text);
    if (amount != null && amount > 0) {
      setState(() {
        balance += amount;
      });
      incomeController.clear();
    }
  }

  void _addExpense() {
    final amount = double.tryParse(expenseAmountController.text);
    final desc = expenseDescController.text;

    if (amount != null && amount > 0 && desc.isNotEmpty) {
      setState(() {
        balance -= amount;
        expenses.add({'amount': amount, 'description': desc});
      });
      expenseAmountController.clear();
      expenseDescController.clear();
    }
  }

  @override
  void dispose() {
    incomeController.dispose();
    expenseAmountController.dispose();
    expenseDescController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Income & Expense Tracker')),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Current Balance: \$${balance.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: incomeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Add Income',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addIncome,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: expenseAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Expense Amount'),
            ),
            TextField(
              controller: expenseDescController,
              decoration: InputDecoration(labelText: 'Expense Description'),
            ),
            ElevatedButton(onPressed: _addExpense, child: Text('Add Expense')),
            SizedBox(height: 20),
            Text('Expenses:', style: TextStyle(fontSize: 18)),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];
                  return ListTile(
                    leading: Icon(Icons.money_off),
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
  }
}
