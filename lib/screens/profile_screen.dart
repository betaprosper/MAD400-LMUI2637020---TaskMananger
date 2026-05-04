import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Custom Colors
    const Color bgColor = Color(0xFFF5F5F5);
    const Color highlightColor = Color(0xFF07CEEB);
    const Color primaryColor = Color(0xFF006579);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // CircleAvatar with Initials
            const CircleAvatar(
              radius: 60,
              backgroundColor: highlightColor,
              child: Text(
                'LP', // Replace with your Initials
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Personal Info Section
            Text(
              'Lifoter Prosper', // Replace with your Full Name
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const Text(
              'Student ID: LMUI2637020', // Replace with your Student ID
              style: TextStyle(fontSize: 16, color: primaryColor),
            ),
            const Text(
              'BTECH in Software Engineering', // Replace with your Programme
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 30),

            // Bio Section
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: primaryColor.withOpacity(0.2)),
              ),
              child: const Column(
                children: [
                  Text(
                    'Personal Bio',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: 18,
                    ),
                  ),
                  Divider(color: highlightColor),
                  Text(
                    'I am a passionate developer currently exploring the world of mobile applications with Flutter. I enjoy solving complex logic problems and design-driven development.', // Replace with your 2-3 sentence bio
                    textAlign: TextAlign.center,
                    style: TextStyle(color: primaryColor, height: 1.5),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Goals Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Top 3 Goals This Semester',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Goal List Items
            _buildGoalItem('1. Master Flutter State Management', highlightColor, primaryColor),
            _buildGoalItem('2. Maintain a GPA above 3.8', highlightColor, primaryColor),
            _buildGoalItem('3. Complete 2 side projects for my portfolio', highlightColor, primaryColor),
          ],
        ),
      ),
    );
  }

  // Helper widget to make goal items look unique
  Widget _buildGoalItem(String goal, Color bulletColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.star_rounded, color: bulletColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              goal,
              style: TextStyle(color: textColor, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}