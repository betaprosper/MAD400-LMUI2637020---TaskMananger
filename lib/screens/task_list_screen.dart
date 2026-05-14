import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_card.dart';
import '../widgets/add_task_bottom_sheet.dart';
import 'task_detail_screen.dart';

enum TaskFilter { all, pending, completed }

enum TaskSort { dueDate, priority }

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
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

  TaskFilter _currentFilter = TaskFilter.all;

  List<Task> get _filteredTasks {
    List<Task> filtered;
    switch (_currentFilter) {
      case TaskFilter.pending:
        filtered = _tasks.where((task) => !task.isCompleted).toList();
        break;
      case TaskFilter.completed:
        filtered = _tasks.where((task) => task.isCompleted).toList();
        break;
      case TaskFilter.all:
      default:
        filtered = List.from(_tasks);
        break;
    }
    return filtered;
  }

  void _deleteTask(Task task) {
    setState(() {
      _tasks.remove(task);
    });
  }

  void _toggleTaskCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
  }

  void _editTask(Task oldTask, Task updatedTask) {
    setState(() {
      final index = _tasks.indexOf(oldTask);
      if (index != -1) {
        _tasks[index] = updatedTask;
      }
    });
  }

  void _sortTasks(TaskSort sortOption) {
    setState(() {
      if (sortOption == TaskSort.dueDate) {
        _tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
      } else if (sortOption == TaskSort.priority) {
        _tasks.sort((a, b) {
          final priorityMap = {'High': 0, 'Medium': 1, 'Low': 2};
          int aPriority = priorityMap[a.priority] ?? 3;
          int bPriority = priorityMap[b.priority] ?? 3;
          return aPriority.compareTo(bPriority);
        });
      }
    });
  }

  void _showAddTaskSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return AddTaskBottomSheet(
          onTaskSave: (newTask) {
            setState(() {
              _tasks.add(newTask);
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredTasks = _filteredTasks;
    final totalTasks = _tasks.length;
    final completedTasks = _tasks.where((t) => t.isCompleted).length;
    final pendingTasks = totalTasks - completedTasks;
    final completionPercentage = totalTasks == 0 ? 0.0 : completedTasks / totalTasks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          PopupMenuButton<TaskSort>(
            icon: const Icon(Icons.sort),
            onSelected: _sortTasks,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: TaskSort.dueDate,
                child: Text("Sort by Due Date"),
              ),
              const PopupMenuItem(
                value: TaskSort.priority,
                child: Text("Sort by Priority"),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Statistics Bar
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.colorScheme.primary.withOpacity(0.2)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem("Total", totalTasks.toString(), theme.colorScheme.primary),
                    _buildStatItem("Completed", completedTasks.toString(), Colors.green),
                    _buildStatItem("Pending", pendingTasks.toString(), theme.colorScheme.secondary),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: completionPercentage,
                    minHeight: 8,
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.secondary),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${(completionPercentage * 100).toInt()}% Completed",
                  style: TextStyle(
                    fontSize: 12, 
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildFilterButton("All", TaskFilter.all),
                const SizedBox(width: 8),
                _buildFilterButton("Pending", TaskFilter.pending),
                const SizedBox(width: 8),
                _buildFilterButton("Completed", TaskFilter.completed),
              ],
            ),
          ),
          Expanded(
            child: _tasks.isEmpty
                ? _buildEmptyState("No tasks yet! Add some to get started.")
                : filteredTasks.isEmpty
                    ? _buildEmptyState("No tasks match this filter.")
                    : ListView.builder(
                        itemCount: filteredTasks.length,
                        itemBuilder: (context, index) {
                          final task = filteredTasks[index];
                          return Dismissible(
                            key: ObjectKey(task),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.redAccent,
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            onDismissed: (direction) {
                              _deleteTask(task);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("${task.title} deleted")),
                              );
                            },
                            child: TaskCard(
                              task: task,
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TaskDetailScreen(
                                      task: task,
                                      onDelete: () => _deleteTask(task),
                                      onToggleComplete: () => _toggleTaskCompletion(task),
                                      onEdit: (updatedTask) => _editTask(task, updatedTask),
                                    ),
                                  ),
                                );
                                setState(() {}); // Refresh list when coming back
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskSheet,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildFilterButton(String label, TaskFilter filter) {
    final isSelected = _currentFilter == filter;
    final theme = Theme.of(context);
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _currentFilter = filter;
          });
        }
      },
      selectedColor: theme.colorScheme.secondary,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : theme.colorScheme.primary,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.task_alt, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
