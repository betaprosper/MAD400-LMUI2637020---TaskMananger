import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/add_task_bottom_sheet.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onToggleComplete;
  final Function(Task) onEdit;

  const TaskDetailScreen({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onToggleComplete,
    required this.onEdit,
  });

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  void _showEditSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return AddTaskBottomSheet(
          taskToEdit: widget.task,
          onTaskSave: (updatedTask) {
            setState(() {
              widget.onEdit(updatedTask);
            });
          },
        );
      },
    );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Task"),
        content: const Text("Are you sure you want to delete this task?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              widget.onDelete();
              Navigator.pop(context); // Return to list
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final secondaryColor = theme.colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _showEditSheet,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _confirmDelete,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.task.title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      decoration: widget.task.isCompleted ? TextDecoration.lineThrough : null,
                      color: widget.task.isCompleted ? Colors.grey : primaryColor,
                    ),
                  ),
                ),
                Chip(
                  label: Text(
                    widget.task.priority,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: _getPriorityColor(widget.task.priority),
                  side: BorderSide.none,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.category_outlined, size: 20, color: secondaryColor),
                const SizedBox(width: 8),
                Text(
                  "Category: ${widget.task.category}",
                  style: TextStyle(fontSize: 16, color: primaryColor.withOpacity(0.8)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 20, color: secondaryColor),
                const SizedBox(width: 8),
                Text(
                  "Due Date: ${widget.task.dueDate.toString().split(' ')[0]}",
                  style: TextStyle(fontSize: 16, color: primaryColor.withOpacity(0.8)),
                ),
              ],
            ),
            const Divider(height: 32),
            Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withOpacity(0.1)),
              ),
              child: Text(
                widget.task.description,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    widget.onToggleComplete();
                  });
                },
                icon: Icon(widget.task.isCompleted ? Icons.undo : Icons.check),
                label: Text(
                  widget.task.isCompleted ? "Mark as Incomplete" : "Mark as Completed",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.task.isCompleted ? Colors.orange : secondaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red[100]!;
      case 'Medium':
        return Colors.orange[100]!;
      case 'Low':
        return Colors.green[100]!;
      default:
        return Colors.grey[100]!;
    }
  }
}
