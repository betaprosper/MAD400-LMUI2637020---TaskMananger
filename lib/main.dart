import 'package:flutter/material.dart';
import 'screens/task_list_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Task 1.1: Disable the debug banner
      debugShowCheckedModeBanner: false,

      title: 'Task Manager',

      // Task 1.1: Create a MaterialApp with a custom theme
      // Using ColorScheme.fromSeed is the modern way to set a theme in Flutter (Material 3)
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF006579), // Deep Purple custom seed
          primary: const Color(0xFF07CEEB),
          secondary: const Color(0xFF625B71),
          surface: const Color(0xFFF5F5F5),
        ),
        // You can also customize individual component themes here
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF006579),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),

      // Task 1.1: Set the home screen to your Task List Screen
      // In main.dart
      home: const TaskListScreen()
      // home: const ProfileScreen(), // Import this file at the top
    );
  }
}