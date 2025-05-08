import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IncomeExpensePage extends StatefulWidget {
  const IncomeExpensePage({super.key});

  @override
  State<IncomeExpensePage> createState() => _IncomeExpensePageState();
}

class _IncomeExpensePageState extends State<IncomeExpensePage> {
  List<Map<String, dynamic>> _transactions = [];
  double _balance = 0.0;
  double _totalExpenses = 0.0;

  @override
  void initState() {
    super.initState();
    // For now, initializing with some dummy data
    _transactions = [
      {'amount': 1000.0, 'description': 'Salary', 'isIncome': true},
      {'amount': 50.0, 'description': 'Groceries', 'isIncome': false},
      {'amount': 200.0, 'description': 'Rent', 'isIncome': false},
      {'amount': 500.0, 'description': 'Freelance Payment', 'isIncome': true},
    ];
    _calculateTotals();
  }

  void _calculateTotals() {
    _balance = 0.0;
    _totalExpenses = 0.0;
    for (var transaction in _transactions) {
      if (transaction['isIncome']) {
        _balance += transaction['amount'];
      } else {
        _balance -= transaction['amount'];
        _totalExpenses += transaction['amount'];
      }
    }
    setState(() {}); // Update the UI with new totals
  }

  void _deleteTransaction(int index) {
    setState(() {
      _transactions.removeAt(index);
    });
    _calculateTotals();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          context.go('/counter'); // Navigate to /counter
        }
      },
      child: LayoutBuilder(
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
                  Text(
                    'Total Expenses: \$${_totalExpenses.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onSecondary,
                        ),
                        onPressed:
                            () => context.push('/income-expense/add-income'),
                        child: const Text('Add Income'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onSecondary,
                        ),
                        onPressed:
                            () => context.push('/income-expense/add-expense'),
                        child: const Text('Add Expense'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('Transactions:', style: TextStyle(fontSize: 18)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = _transactions[index];
                        return ListTile(
                          leading: Icon(
                            transaction['isIncome']
                                ? Icons.add_circle
                                : Icons.remove_circle,
                            color:
                                transaction['isIncome']
                                    ? Colors.green
                                    : Colors.red,
                          ),
                          title: Text('\$${transaction['amount']}'),
                          subtitle: Text(transaction['description']),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteTransaction(index),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
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
                Text(
                  'Total Expenses: \$${_totalExpenses.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onSecondary,
                      ),
                      onPressed:
                          () => context.push('/income-expense/add-income'),
                      child: const Text('Add Income'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onSecondary,
                      ),
                      onPressed:
                          () => context.push('/income-expense/add-expense'),
                      child: const Text('Add Expense'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text('Transactions:', style: TextStyle(fontSize: 18)),
                Expanded(
                  child: ListView.builder(
                    itemCount: _transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = _transactions[index];
                      return ListTile(
                        leading: Icon(
                          transaction['isIncome']
                              ? Icons.add_circle
                              : Icons.remove_circle,
                          color:
                              transaction['isIncome']
                                  ? Colors.green
                                  : Colors.red,
                        ),
                        title: Text('\$${transaction['amount']}'),
                        subtitle: Text(transaction['description']),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteTransaction(index),
                        ),
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
