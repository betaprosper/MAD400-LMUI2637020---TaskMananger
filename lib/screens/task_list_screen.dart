import 'package:flutter/material.dart';
import '../widgets/task_card.dart'; // Import your widget

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks')),
      body: ListView(
        children: const [
          TaskCard(title: "Complete Flutter Structure"),
          TaskCard(title: "Set up TaskDetailScreen"),
        ],
      ),
    );
  }
}