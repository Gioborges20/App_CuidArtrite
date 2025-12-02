import 'package:flutter/material.dart';

class ChartCard extends StatelessWidget {
  final String title;
  final Widget chart;

  const ChartCard({
    super.key,
    required this.title,
    required this.chart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: chart, // gráfico recebido
            ),
          ],
        ),
      ),
    );
  }
}