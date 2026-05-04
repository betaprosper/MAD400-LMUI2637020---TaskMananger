import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_card.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // Initial sample data
  final List<Task> _tasks = [
    Task(
      title: "Complete Flutter Project",
      description: "Finish the core features of the task manager.",
      category: "School",
      priority: "High",
      dueDate: DateTime.now().add(const Duration(days: 2)),
    ),
    Task(
      title: "Buy Groceries",
      description: "Milk, eggs, and bread.",
      category: "Personal",
      priority: "Medium",
      dueDate: DateTime.now(),
      isCompleted: true,
    ),
    Task(
      title: "Morning Jog",
      description: "Go for a 5km run.",
      category: "Health",
      priority: "Low",
      dueDate: DateTime.now().add(const Duration(days: 1)),
    ),
  ];

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks')),
      body: _tasks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.task_alt, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  const Text(
                    "No tasks yet! Add some to get started.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Dismissible(
                  key: Key(task.title + task.dueDate.toString()), // Using a combination as a key
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    _deleteTask(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${task.title} deleted")),
                    );
                  },
                  child: TaskCard(
                    task: task,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailScreen(task: task),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
