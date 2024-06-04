import 'package:flutter/material.dart';

// ChartBar is a stateless widget that represents a single bar in a chart.
class ChartBar extends StatelessWidget {
  // Constructor requires a 'fill' value that determines the height of the bar.
  const ChartBar({
    super.key,
    required this.fill,  // 'fill' is a fraction between 0.0 and 1.0
  });

  // The fill fraction of the bar (e.g., 0.5 for half-filled).
  final double fill;

  @override
  Widget build(BuildContext context) {
    // Determines if the app is in dark mode or light mode.
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Expanded widget makes the bar expand to fill available space horizontally.
    return Expanded(
      child: Padding(
        // Padding on the sides for spacing between bars.
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          // The height of the box is determined by the 'fill' value.
          heightFactor: fill,
          child: DecoratedBox(
            // Decoration for the bar.
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,  // Rectangular shape.
              // Rounded corners at the top.
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              // The color of the bar changes based on the theme's brightness.
              color: isDarkMode
                  ? Theme.of(context).colorScheme.secondary  // Color for dark mode.
                  : Theme.of(context).colorScheme.primary.withOpacity(0.65),  // Color for light mode.
            ),
          ),
        ),
      ),
    );
  }
}
