import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  const TaskCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.check_circle_outline),
      ),
    );
  }
}