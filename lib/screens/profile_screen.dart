import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final secondaryColor = theme.colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // CircleAvatar with Initials
            CircleAvatar(
              radius: 60,
              backgroundColor: secondaryColor,
              child: Text(
                'LP',
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
              'Lifoter Prosper',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              'Student ID: LMUI2637020',
              style: TextStyle(fontSize: 16, color: primaryColor.withOpacity(0.8)),
            ),
            Text(
              'BTECH in Software Engineering',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: primaryColor.withOpacity(0.8),
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Personal Bio',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: 18,
                    ),
                  ),
                  Divider(color: secondaryColor),
                  Text(
                    'I am a passionate developer currently exploring the world of mobile applications with Flutter. I enjoy solving complex logic problems and design-driven development.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: primaryColor.withOpacity(0.9), height: 1.5),
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
            _buildGoalItem('1. Master Flutter State Management', secondaryColor, primaryColor),
            _buildGoalItem('2. Maintain a GPA above 3.8', secondaryColor, primaryColor),
            _buildGoalItem('3. Complete 2 side projects for my portfolio', secondaryColor, primaryColor),
          ],
        ),
      ),
    );
  }

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
