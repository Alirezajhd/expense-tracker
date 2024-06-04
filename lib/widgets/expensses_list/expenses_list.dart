import 'package:flutter/material.dart';
import 'package:flutter_proje_3/data/expense.dart';
import 'package:flutter_proje_3/widgets/expensses_list/expense_item.dart';

// ExpensesList widget displays a list of ExpenseItem widgets.
class ExpensesList extends StatelessWidget {
  // Constructor requires a list of expenses and a function to handle removal.
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  // List of Expense objects to be displayed.
  final List<Expense> expenses;
  // Callback function to handle the removal of an expense.
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    // Using ListView.builder for efficient rendering of list items.
    return ListView.builder(
      itemCount: expenses.length, // Number of items in the list.
      itemBuilder: (ctx, index) => Dismissible(
        // Dismissible widget allows each item to be swiped away.
        background: Container(
          // Red background appears when swiping an item.
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          // Margin to match the theme's card margin.
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          )),
        key: ValueKey(expenses[index]), // Unique key for Dismissible.
        onDismissed: (direction) {
          // Callback when the item is dismissed.
          onRemoveExpense(expenses[index]);
        },
        // The actual ExpenseItem widget for each expense.
        child: ExpenseItem(
          expenses[index],
        ),
      ),
    );
  }
}
