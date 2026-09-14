import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'lawyers/lawyers_directory_screen.dart';
import 'consultations/consultations_screen.dart';
import 'cases/my_cases_screen.dart';
import 'profile/profile_screen.dart';
import '../widgets/bottom_nav_bar.dart';

/// Hosts the 5 main tabs behind the bottom navigation bar.
class MainShell extends StatefulWidget {
  final ValueChanged<bool> onDarkModeChanged;
  final bool isDarkMode;

  const MainShell({
    super.key,
    required this.onDarkModeChanged,
    required this.isDarkMode,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  List<Widget> get _screens => [
        const HomeScreen(),
        const LawyersDirectoryScreen(),
        const ConsultationsScreen(),
        const MyCasesScreen(),
        ProfileScreen(
          isDarkMode: widget.isDarkMode,
          onDarkModeChanged: widget.onDarkModeChanged,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: HuqouqiBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
