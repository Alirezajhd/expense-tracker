import 'package:flutter/material.dart';
import 'package:flutter_proje_3/data/expense.dart';

// ExpenseItem widget displays details of a single expense.
class ExpenseItem extends StatelessWidget {
  // Constructor takes an Expense object to display.
  const ExpenseItem(this.expense, {super.key});

  // The Expense object containing the details to be displayed.
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      // Wrapping the content in a Card widget for better UI.
      child: Padding(
        // Padding around the content inside the card.
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          // Aligning content to start of the column.
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displaying the title of the expense.
            Text(
              expense.title,
              // Using the large title text theme for styling.
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4, // Adding a small space between the title and the row.
            ),
            Row(
              // A row to display the amount and date horizontally.
              children: [
                // Showing the expense amount.
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(), // A spacer to push the next row to the end.
                Row(
                  // Row for the category icon and date.
                  children: [
                    // Displaying an icon based on the expense category.
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(
                      width: 8, // Spacing between the icon and the date.
                    ),
                    // Displaying the date of the expense.
                    Text(expense.date.toString()),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
