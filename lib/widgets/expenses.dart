import 'package:flutter/material.dart';
import 'package:flutter_proje_3/data/expense.dart';
import 'package:flutter_proje_3/widgets/chart/chart.dart';
import 'package:flutter_proje_3/widgets/expensses_list/expenses_list.dart';
import 'package:flutter_proje_3/widgets/new_expense.dart';

// The main widget for the expense tracker app.
class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  // A list to keep track of the expenses.
  final List<Expense> _registerExpenses = [
    // Initial sample expenses.
    Expense(
        title: 'Flutter course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 15.69,
        date: DateTime.now(),
        category: Category.leisure)
  ];

  // Function to add a new expense to the list.
  void _addExpenses(Expense expense) {
    setState(() {
      _registerExpenses.add(expense);
    });
  }

  // Function to open a modal bottom sheet to add a new expense.
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true, // Ensures safe area (e.g., avoiding notch).
        isScrollControlled: true, // Allows the modal to be scrollable.
        context: context,
        builder: (ctx) => NewExpense(
              onAddExpense: _addExpenses,
            ));
  }

  // Function to remove an expense from the list.
  void _removeExpense(Expense expense) {
    final expenseIndex = _registerExpenses.indexOf(expense);
    setState(() {
      _registerExpenses.remove(expense);
    });
    // Showing a snackbar with an option to undo the deletion.
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registerExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Getting the width of the screen to determine the layout.
    final width = MediaQuery.of(context).size.width;
    
    // Default content when there are no expenses.
    Widget mainContent = const Center(
      child: Text('No expenses found, Start adding some!'),
    );

    // Updating the main content if there are expenses.
    if (_registerExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registerExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    // The main UI of the app.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      // Responsive layout based on the screen width.
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registerExpenses), // Chart widget for expenses.
                Expanded(
                  child: mainContent, // Either the list of expenses or a message.
                ),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registerExpenses)),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
